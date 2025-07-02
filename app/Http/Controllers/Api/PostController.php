<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class PostController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResponse
    {
        $posts = Post::with('autor')->get();
        return response()->json($posts);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'titulo' => 'required|string|max:255',
            'contenido' => 'required|string',
            'imagen' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
            'autor_id' => 'required|exists:autores,id',
        ]);

        $data = $request->all();
        
        if ($request->hasFile('imagen')) {
            $image = $request->file('imagen');
            $imageName = time() . '.' . $image->getClientOriginalExtension();
            $image->move(public_path('images'), $imageName);
            $data['imagen'] = 'images/' . $imageName;
        }

        $post = Post::create($data);
        $post->load('autor');
        return response()->json($post, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id): JsonResponse
    {
        $post = Post::with('autor')->findOrFail($id);
        return response()->json($post);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id): JsonResponse
    {
        $request->validate([
            'titulo' => 'required|string|max:255',
            'contenido' => 'required|string',
            'imagen' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            'autor_id' => 'required|exists:autores,id',
        ]);

        $post = Post::findOrFail($id);
        $data = $request->all();
        
        if ($request->hasFile('imagen')) {
            // Delete old image
            if ($post->imagen && file_exists(public_path($post->imagen))) {
                unlink(public_path($post->imagen));
            }
            
            $image = $request->file('imagen');
            $imageName = time() . '.' . $image->getClientOriginalExtension();
            $image->move(public_path('images'), $imageName);
            $data['imagen'] = 'images/' . $imageName;
        }

        $post->update($data);
        $post->load('autor');
        return response()->json($post);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id): JsonResponse
    {
        $post = Post::findOrFail($id);
        
        // Delete image file
        if ($post->imagen && file_exists(public_path($post->imagen))) {
            unlink(public_path($post->imagen));
        }
        
        $post->delete();
        return response()->json(null, 204);
    }
}
