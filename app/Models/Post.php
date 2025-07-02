<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use HasFactory;

    protected $fillable = [
        'titulo',
        'contenido',
        'imagen',
        'autor_id'
    ];

    public function autor()
    {
        return $this->belongsTo(Autor::class, 'autor_id');
    }
}