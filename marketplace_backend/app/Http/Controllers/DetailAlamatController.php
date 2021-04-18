<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class DetailAlamatController extends Controller
{
    public function getProvinsi()
    {
        $all = DB::select("SELECT * FROM tb_ro_provinces");
        return response()->json($all);
    }

    public function getKota(Request $request)
    {
       $idProvinsi = $request->input('province_id');
      

       $kota = DB::select("SELECT * FROM tb_ro_cities WHERE province_id = $idProvinsi");

       return response()->json($kota);
    }

    public function getKec(Request $request)
    {
       $idKota = $request->input('city_id');
      

       $kecamatan = DB::select("SELECT * FROM tb_ro_subdistricts WHERE city_id = $idKota");

       return response()->json($kecamatan);
    }

}
