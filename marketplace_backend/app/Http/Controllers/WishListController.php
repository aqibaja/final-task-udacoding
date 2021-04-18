<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Carbon\Carbon;


class WishListController extends Controller
{


    public function checkWish(Request $request)
    {
       $idKonsumen = $request->input('id_konsumen');

       $reseller = DB::table('rb_konsumen_simpan')->where('id_konsumen',$idKonsumen)->first();

       if ($reseller) {
        /* $pesan = 'Data Exist';
        $sukses = 'true';
        return $this->responseRequestSuccess($pesan,$sukses); */
        $product = DB::table('rb_produk')->select(DB::raw('*,rb_produk.id_produk as id, harga_konsumen - diskon AS fix_harga'))
        ->leftjoin('rb_produk_diskon', 'rb_produk.id_produk', '=', 'rb_produk_diskon.id_produk')
        ->leftjoin('rb_konsumen_simpan', 'rb_produk.id_produk', '=', 'rb_konsumen_simpan.id_produk')
        ->where('rb_konsumen_simpan.id_konsumen', $idKonsumen )
        ->get();
        return response()->json($product);
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


    
    