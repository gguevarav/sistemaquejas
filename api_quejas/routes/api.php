<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\ProveedoresController;
use App\Http\Controllers\QuejasController;
use App\Http\Controllers\MunicipiosController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// Proveedores
Route::get('/proveedores', [ProveedoresController::class, 'index']);
Route::post('/proveedores', [ProveedoresController::class, 'store']);
Route::get('/proveedores/{id}', [ProveedoresController::class, 'show']);

//Quejas
Route::get('/quejas', [QuejasController::class, 'index']);
Route::post('/quejas', [QuejasController::class, 'store']);
Route::get('/quejas/{id}', [QuejasController::class, 'show']);

//Quejas
Route::get('/municipios', [MunicipiosController::class, 'index']);