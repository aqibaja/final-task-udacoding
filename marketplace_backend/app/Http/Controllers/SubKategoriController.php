<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;

use App\Models\SubKategori; // model database
use Illuminate\Http\Request;

class SubKategoriController extends Controller
{
    public function showAllSubKategori()
    {
        $all = DB::select("SELECT * FROM rb_kategori_produk_sub");
        return response()->json($all);
    }

    public function showSpecificSubKategori($id)
    {
        $subKategori = SubKategori::WHERE('id_kategori_produk', $id)->get();
        return response()->json($subKategori);
    } 


    public function showAllSubKategoriAndProduct($id)
    {
        $subKategori = DB::table('rb_kategori_produk_sub')->select('*')
        ->leftjoin('rb_produk', 'rb_kategori_produk_sub.id_kategori_produk_sub', '=', 'rb_produk.id_kategori_produk_sub')
        ->where('rb_kategori_produk_sub.id_kategori_produk_sub', '=', $id)
        ->get();
        return response()->json($subKategori);
    } 
        
}
