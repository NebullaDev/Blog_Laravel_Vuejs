<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Autor;

class AutorSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $autores = [
            [
                'nombre' => 'Juan',
                'apellidos' => 'Pérez García'
            ],
            [
                'nombre' => 'María',
                'apellidos' => 'López Martínez'
            ],
            [
                'nombre' => 'Carlos',
                'apellidos' => 'González Rodríguez'
            ],
            [
                'nombre' => 'Ana',
                'apellidos' => 'Sánchez Torres'
            ]
        ];

        foreach ($autores as $autor) {
            Autor::create($autor);
        }
    }
}
