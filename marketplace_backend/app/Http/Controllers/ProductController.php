<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;

use App\Models\Product; // model database
use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Http\Request;
use Carbon\Carbon as Time;

class ProductController extends Controller
{
    public function showAllSubProduct()
    {
        $all = DB::select("SELECT * FROM rb_produk");
        return response()->json($all);
    }

    public function showSpecificProduct($id)
    {
        $product= Product::WHERE('id_produk', $id)->get();
        return response()->json($product);
    } 

    public function showKategoriProduct($id)
    {
        $product = DB::table('rb_produk')->select(DB::raw('rb_produk.nama_produk,rb_produk.id_produk, rb_produk.gambar,rb_produk.harga_konsumen, rb_produk.harga_konsumen - rb_produk_diskon.diskon as fix_harga, AVG(rating) as rating')) // ,AVG(rating) AS rating
        ->leftjoin('rb_produk_diskon', 'rb_produk.id_produk', '=', 'rb_produk_diskon.id_produk')
        ->leftjoin('rb_produk_ulasan', 'rb_produk.id_produk', '=', 'rb_produk_ulasan.id_produk')
        ->where('rb_produk.id_kategori_produk_sub', $id)
        ->groupBy('rb_produk.id_produk')
        ->get();
        return response()->json($product);
    } 

    public function joinProductVariasiDiskon($id)
    {
        $product = DB::table('rb_produk')->select(DB::raw('*, harga_konsumen - diskon AS fix_harga'))
        ->leftjoin('rb_produk_diskon', 'rb_produk.id_produk', '=', 'rb_produk_diskon.id_produk')
        ->leftjoin('rb_produk_variasi', 'rb_produk.id_produk', '=', 'rb_produk_variasi.id_produk')
        ->where('rb_produk.id_produk', '=', $id)
        ->get();
        return response()->json($product);
    } 
    
    public function showUlasan($id)
    {
        $product = DB::table('rb_produk_ulasan')->select(DB::raw('*'))
        ->leftjoin('rb_konsumen', 'rb_produk_ulasan.id_konsumen', '=', 'rb_konsumen.id_konsumen')
        ->where('rb_produk_ulasan.id_produk', $id)
        ->get();
        return response()->json($product);
    } 

    public function showAllPoductPopular()
    {
        $product = DB::table('rb_produk')->select(DB::raw('*,rb_produk.id_produk as id, harga_konsumen - diskon AS fix_harga'))
        ->leftjoin('rb_produk_diskon', 'rb_produk.id_produk', '=', 'rb_produk_diskon.id_produk')
        ->leftjoin('rb_produk_ulasan', 'rb_produk.id_produk', '=', 'rb_produk_ulasan.id_produk')
        ->orderBy('waktu_input', 'desc')
        ->orderBy('dilihat', 'asc')
        ->limit(8)
        ->get();
        return response()->json($product);
    }

    public function showAllPoductDiskon()
    {
        $product = DB::table('rb_produk')->select(DB::raw('*,rb_produk.id_produk as id, harga_konsumen - diskon AS fix_harga'))
        ->leftjoin('rb_produk_diskon', 'rb_produk.id_produk', '=', 'rb_produk_diskon.id_produk')
        ->leftjoin('rb_produk_ulasan', 'rb_produk.id_produk', '=', 'rb_produk_ulasan.id_produk')
        ->orderBy('waktu_input', 'desc')
        ->where('diskon',"!=", "0" )
        ->limit(15)
        ->get();
        return response()->json($product);
    }

    public function checkFavorite(Request $request)
    {
        $idKonsumen = $request->input('id_konsumen');
        $idProduct = $request->input('id_product');

        $favorite = DB::select("SELECT * FROM `rb_konsumen_simpan` WHERE rb_konsumen_simpan.id_konsumen = $idKonsumen AND rb_konsumen_simpan.id_produk = $idProduct");
        
        if($favorite){
        return response()->json($favorite, 200);
        }
        else {
            return response()->json($favorite, 400);
        }
    } 

    public function addFavorite(Request $request)
    {
        $idKonsumen = $request->input('id_konsumen');
        $idProduct = $request->input('id_product');
        $date = Time::now()->toDateTimeString();

        $addFavorite = DB::insert("INSERT INTO `rb_konsumen_simpan` (`id_konsumen`, `id_produk`, `waktu_simpan`) VALUES ($idKonsumen, $idProduct, '$date')");
        if($addFavorite){
            return response()->json([
                'success' => "true",
                'message' => 'Register Success!',
                'data' => "berhasil"
            ], 200);
       } else {
        return response()->json([
            'success' => "false",
            'message' => 'Register fail!',
            'data' => ''
        ], 400);
       }
    } 

    public function deleteFavorite(Request $request)
    {
        $idKonsumen = $request->input('id_konsumen');
        $idProduct = $request->input('id_product');

        $user = DB::table('rb_konsumen_simpan')
       ->where('id_konsumen',$idKonsumen)
       ->where('id_produk', $idProduct);
       

        if($user){
            $user->delete();
            return response()->json([
                'success' => "true",
                'message' => 'Hapus Success!',
                'data' => "berhasil"
            ], 200);
        }else {
        return response()->json([
            'success' => "false",
            'message' => 'Hapus fail!',
            'data' => ''
        ], 400);
    }
    } 

    public function listFavorite(Request $request)
    {
       $idKonsumen = $request->input('id_konsumen');

       $reseller = DB::table('rb_konsumen_simpan')->where('id_konsumen',$idKonsumen)->first();

       if ($reseller) {
        /* $pesan = 'Data Exist';
        $sukses = 'true';
        return $this->responseRequestSuccess($pesan,$sukses); */
        $product = DB::table('rb_produk')->select(DB::raw('*,rb_produk.id_produk as id, harga_konsumen - diskon AS fix_harga'))
        ->leftjoin('rb_produk_diskon', 'rb_produk.id_produk', '=', 'rb_produk_diskon.id_produk')
        /* ->leftjoin('rb_produk_ulasan', 'rb_produk.id_produk', '=', 'rb_produk_ulasan.id_produk') */
        ->leftjoin('rb_konsumen_simpan', 'rb_produk.id_produk', '=', 'rb_konsumen_simpan.id_produk')
        ->where('rb_konsumen_simpan.id_konsumen',  $idKonsumen )
        /* ->groupBy('rb_produk.id_produk') */
        ->get();
        
        return response()->json($product);
        } 
        else {
        $pesan = 'Data not Exist';
        $sukses =  'false';
        return $this->responseRequestError($pesan,$sukses);
        }
    }


    public function addCart(Request $request)
    {
        $idKonsumen = $request->input('id_konsumen');
        $idProduct = $request->input('id_product');
        $date = Time::now()->toDateTimeString();

        $addFavorite = DB::insert("INSERT INTO `rb_konsumen_cart` (`id_konsumen`, `id_produk`, `waktu_simpan`) VALUES ($idKonsumen, $idProduct, '$date')");
        if($addFavorite){
            return response()->json([
                'success' => "true",
                'message' => 'Register Success!',
                'data' => "berhasil"
            ], 200);
       } else {
        return response()->json([
            'success' => "false",
            'message' => 'Register fail!',
            'data' => ''
        ], 400);
       }
    } 

    public function deleteCart(Request $request)
    {
        $idKonsumen = $request->input('id_konsumen');
        $idProduct = $request->input('id_product');

        $user = DB::table('rb_konsumen_cart')
       ->where('id_konsumen',$idKonsumen)
       ->where('id_produk', $idProduct);

       $addFavorite = DB::insert("INSERT INTO `rb_konsumen_cart` (`id_konsumen`, `id_produk`, `waktu_simpan`) VALUES ($idKonsumen, $idProduct, '$date')");
       if($addFavorite){
           return response()->json([
               'success' => "true",
               'message' => 'Register Success!',
               'data' => "berhasil"
           ], 200);
      } else {
       return response()->json([
           'success' => "false",
           'message' => 'Register fail!',
           'data' => ''
       ], 400);
      }
    } 

    public function addTotalCart(Request $request)
    {
        $idKonsumen = $request->input('id_konsumen');
        $idProduct = $request->input('id_product');

        $updateTotal = DB::table('rb_konsumen_cart')
       ->where('id_konsumen',$idKonsumen)
       ->where('id_produk', $idProduct)
       ->first();


        if($updateTotal){
            $total = $updateTotal->total;
            $update = DB::table('rb_konsumen_cart')
            ->where('id_konsumen',$idKonsumen)
            ->where('id_produk', $idProduct)
            ->update(['total' => $total + 1]);

            return response()->json([
                'success' => "true",
                'message' => 'Hapus Success!',
                'data' => "berhasil"
            ], 200);
        }else {
        return response()->json([
            'success' => "false",
            'message' => 'Hapus fail!',
            'data' => ''
        ], 400);
    }
    }

    public function removeTotalCart(Request $request)
    {
        $idKonsumen = $request->input('id_konsumen');
        $idProduct = $request->input('id_product');

        $updateTotal = DB::table('rb_konsumen_cart')
       ->where('id_konsumen',$idKonsumen)
       ->where('id_produk', $idProduct)
       ->first();


        if($updateTotal){
            $total = $updateTotal->total;
            if($total > 1){
            $update = DB::table('rb_konsumen_cart')
            ->where('id_konsumen',$idKonsumen)
            ->where('id_produk', $idProduct)
            ->update(['total' => $total - 1]);
            }else{
                $user = DB::table('rb_konsumen_cart')
                ->where('id_konsumen',$idKonsumen)
                ->where('id_produk', $idProduct);
                
                $user->delete();
            }
            

            return response()->json([
                'success' => "true",
                'message' => 'Hapus Success!',
                'data' => "berhasil"
            ], 200);
        }else {
        return response()->json([
            'success' => "false",
            'message' => 'Hapus fail!',
            'data' => ''
        ], 400);
    }
    }

    public function listCart(Request $request)
    {
       $idKonsumen = $request->input('id_konsumen');

       $reseller = DB::table('rb_konsumen_cart')->where('id_konsumen',$idKonsumen)->first();

       if ($reseller) {
        /* $pesan = 'Data Exist';
        $sukses = 'true';
        return $this->responseRequestSuccess($pesan,$sukses); */
        $product = DB::table('rb_produk')->select(DB::raw('*,rb_produk.id_produk as id, harga_konsumen - diskon AS fix_harga'))
        ->leftjoin('rb_produk_diskon', 'rb_produk.id_produk', '=', 'rb_produk_diskon.id_produk')
        /* ->leftjoin('rb_produk_ulasan', 'rb_produk.id_produk', '=', 'rb_produk_ulasan.id_produk') */
        ->leftjoin('rb_konsumen_cart', 'rb_produk.id_produk', '=', 'rb_konsumen_cart.id_produk')
        ->where('rb_konsumen_cart.id_konsumen',  $idKonsumen )
        /* ->groupBy('rb_produk.id_produk') */
        ->get();
        
        return response()->json($product);
        } 
        else {
        $pesan = 'Data not Exist';
        $sukses =  'false';
        return $this->responseRequestError($pesan,$sukses);
        }
    }

    protected function responseRequestSuccess($message, $success)
    {
    return response()->json(['success' => $success,'message' => $message], 200)
        ->header('Access-Control-Allow-Origin', '*')
        ->header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    }

    protected function responseRequestError($message, $success, $statusCode = 400)
    {
    return response()->json(['success' => $success, 'message' => $message], $statusCode)
        ->header('Access-Control-Allow-Origin', '*')
        ->header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
     }



}
