<?php

namespace App\Http\Controllers;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Queja;
use Illuminate\Support\Facades\DB;

class QuejasController extends BaseController
{
    public function index(){
        // Creamos el join para obtener el array de los datos
        $Datos = DB::table('Queja')
                        ->join('Proveedor', 'Queja.idProveedor', '=', 'Proveedor.idProveedor')
                        ->select('Queja.*', 'Proveedor.*')
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
        $Datos = array("NumeroFactura"=>$request->input("NumeroFactura"),
                       "Fecha"=>$request->input("Fecha"),
                       "Queja"=>$request->input("Queja"),
                       "Sugerencia"=>$request->input("Sugerencia"),
                       "idProveedor"=>$request->input("idProveedor"));

        // Validamos que los Datos no estén vacios
        if(!empty($Datos)){
            // Separamos la validación
            // Reglas
            $Reglas = [
                "NumeroFactura" => 'required|string|max:255',
                "Fecha" => 'required|date',
                "Queja" => 'required|string|max:255',
                "Sugerencia" => 'required|string|max:255',
                "idProveedor" => 'required|integer'];

            $Mensajes = [
                "NumeroFactura.required" => 'Es necesario agregar un numero de factura',
                "Fecha.required" => 'Es necesario agregar una fecha',
                "Queja.required" => 'Es necesario agregar una queja',
                "Sugerencia.required" => 'Es necesario agregar una sugerencia',
                "idProveedor.required" => 'Es necesario agregar un proveedor'];
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
                $Queja = new Queja();

                // Ingresamos los datos
                $Queja->NumeroFactura = $Datos["NumeroFactura"];
                $Queja->Fecha = $Datos["Fecha"];
                $Queja->Queja = $Datos["Queja"];
                $Queja->Sugerencia = $Datos["Sugerencia"];
                $Queja->idProveedor = $Datos["idProveedor"];

                // Ejecutamos la acción de guardar el usuario
                $Queja->save();

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
        $Queja = Queja::where("idQueja", $id)->get();
        // Verificamos que el array no esté vacio
        if ($Proveedor != "[]" && !empty($Queja)) {
            $json = array(
                'status' => 200,
                'detalle' => $Queja
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
