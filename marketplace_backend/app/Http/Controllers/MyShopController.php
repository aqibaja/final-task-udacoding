<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Carbon\Carbon;


class MyShopController extends Controller
{


    public function checkShop(Request $request)
    {
       $idKonsumen = $request->input('id_konsumen');

       $reseller = DB::table('rb_reseller')->where('id_konsumen',$idKonsumen)->first();

       if ($reseller) {
        $pesan = 'Data Exist';
        $sukses = 'true';

        return $this->responseRequestSuccess($pesan,$sukses);
        } 
        else {
        $pesan = 'Data not Exist';
        $sukses =  'false';
        return $this->responseRequestSuccess($pesan,$sukses);
        }
    }

    public function createShop(Request $request)
    {
       $idKonsumen = $request->input('id_konsumen');

       $reseller = DB::table('rb_reseller')->where('id_konsumen',$idKonsumen)->first();

       if ($reseller) {
        $pesan = 'Data Exist'; 
        $sukses = 'false';
        return $this->responseRequestSuccess($pesan,$sukses);
        } 
        else {
            $sukses = 'true';
            $pesan = 'Data Inserted';

            $user = DB::table('rb_konsumen')->where('id_konsumen',$idKonsumen)->first();
            $tanggal_daftar = Carbon::now();

            $reseller = DB::table('rb_reseller')->insert([
                'id_konsumen' => $user->id_konsumen,
                'user_reseller' => $user->username,
                'nama_reseller' => 'My-shop-'.$user->username,
                'kecamatan_id' => $user->kecamatan_id ,
                'kota_id' =>$user->kota_id ,
                'provinsi_id' => $user->provinsi_id ,
                'tanggal_daftar' => $tanggal_daftar ,
                'no_telpon' => $user->no_hp
            ]);

        return $this->responseRequestSuccess($pesan,$sukses);
        }
    }





    protected function responseRequestSuccess($message, $success)
    {
    return response()->json(['success' => $success,'message' => $message], 200)
        ->header('Access-Control-Allow-Origin', '*')
        ->header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    }

    protected function responseRequestError($message = 'Bad request', $statusCode = 200)
    {
    return response()->json(['status' => 'error', 'error' => $message], $statusCode)
        ->header('Access-Control-Allow-Origin', '*')
        ->header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
     }

}


    
    