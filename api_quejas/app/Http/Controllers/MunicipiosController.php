<?php

namespace App\Http\Controllers;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Municipio;
use Illuminate\Support\Facades\DB;

class MunicipiosController extends BaseController
{
    public function index(){
        // Creamos el join para obtener el array de los datos
        $Datos = DB::table('Municipio')
                        ->join('Departamento', 'Municipio.idDepartamento', '=', 'Departamento.idDepartamento')
                        ->select('Municipio.*', 'Departamento.NombreDepartamento')
                        ->get();

        // Verificamos que el array no esté vacio
        if (!empty($Datos[0])) {
            $json = array(
                'status' => 200,
                'total' => count($Datos),
                'detalle' => $Datos
            );
        }else{
            $json = array(
                'status' => 200,
                'total' => 0,
                'detalle' => "No hay registros"
            );
        }
        // Mostramos la información como un json
        return response()->json($json);
    }
}
