<?php

namespace App\Http\Controllers;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Proveedor;
use Illuminate\Support\Facades\DB;

class ProveedoresController extends BaseController
{
    public function index(){
        // Creamos el join para obtener el array de los datos
        $Datos = DB::table('Proveedor')
                        ->join('Municipio', 'Proveedor.MunicipioSede', '=', 'Municipio.idMunicipio')
                        ->select('Proveedor.*', 'Municipio.NombreMunicipio')
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

    public function store(Request $request){
        // Inicializamos una variable para almacenar un json nulo
        $json = null;
        // Recogemos los Datos que almacenaremos, los ingresamos a un array
        $Datos = array("NombreProveedor"=>$request->input("NombreProveedor"),
                       "NumeroNIT"=>$request->input("NumeroNIT"),
                       "Direccion"=>$request->input("Direccion"),
                       "MunicipioSede"=>$request->input("MunicipioSede"));

        // Validamos que los Datos no estén vacios
        if(!empty($Datos)){
            // Separamos la validación
            // Reglas
            $Reglas = [
                "NombreProveedor" => 'required|string|max:255',
                "NumeroNIT" => 'required|string|max:255',
                "Direccion" => 'required|string|max:255',
                "MunicipioSede" => 'required|integer'];

            $Mensajes = [
                "NombreProveedor.required" => 'Es necesario agregar un nombre del proveedor',
                "NumeroNIT.required" => 'Es necesario agregar un número de NIT',
                "Direccion.required" => 'Es necesario agregar una dirección',
                "MunicipioSede.required" => 'Es necesario agregar una sede'];
            // Validamos los Datos antes de insertarlos en la base de Datos
            $validacion = Validator::make($Datos,$Reglas,$Mensajes);

            // Revisamos la validación
            if($validacion->fails()){
                // Devolvemos el mensaje que falló la validación de Datos
                $json = array(
                    "status" => 404,
                    "detalle" => "Los registros tienen errores",
                    "errores" => $validacion->errors()->all()
                );
            }else{
                // instanciamos un nuevo objeto para registro
                $Proveedor = new Proveedor();

                // Ingresamos los datos
                $Proveedor->NombreProveedor = $Datos["NombreProveedor"];
                $Proveedor->NumeroNIT = $Datos["NumeroNIT"];
                $Proveedor->Direccion = $Datos["Direccion"];
                $Proveedor->MunicipioSede = $Datos["MunicipioSede"];

                // Ejecutamos la acción de guardar el usuario
                $Proveedor->save();

                $json = array(
                    "status" => 200,
                    "detalle" => "Registro exitoso"
                );
            }
        }else{
            $json = array(
                "status" => 404,
                "detalle" => "Registro con errores"
            );
        }
        // Devolvemos la respuesta en un Json
        return response()->json($json);
    }

    public function show($id, Request $request){
        // Inicializamos una variable para almacenar un json nulo
        $json = null;
        // Primero obtenemos todos los registros y los almacenamos en un array
        $Proveedor = Proveedor::where("idProveedor", $id)->get();
        // Verificamos que el array no esté vacio
        if ($Proveedor != "[]" && !empty($Proveedor)) {
            $json = array(
                'status' => 200,
                'detalle' => $Proveedor
            );
        }else{
            $json = array(
                'status' => 200,
                'detalle' => "Registro no encontrado."
            );
        }
        // Devolvemos la respuesta en un Json
        return response()->json($json);
    }
}
