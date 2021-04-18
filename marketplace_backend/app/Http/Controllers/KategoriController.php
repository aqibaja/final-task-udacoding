<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use App\Models\Kategori; // model database
use Illuminate\Http\Request;

class KategoriController extends Controller
{
    public function showAllKategori()
    {
        return response()->json(Kategori::all());
    }

    public function showOneKategori($id)
    {
        return response()->json(Kategori::find($id));
    }

    public function create(Request $request)
    {
        $author = Kategori::create($request->all());

        return response()->json($author, 201);
    }

    public function update($id, Request $request)
    {
        $author = Kategori::findOrFail($id);
        $author->update($request->all());

        return response()->json($author, 200);
    }

    public function delete($id)
    {
        Kategori::findOrFail($id)->delete();
        return response('Deleted Successfully', 200);
    }

    //mengambil product berdasarkan kategori
    public function showAllKategoriAndProduct($id)
    {
        $subKategori = DB::table('rb_kategori_produk')->select('*')
        ->leftjoin('rb_produk', 'rb_kategori_produk.id_kategori_produk', '=', 'rb_produk.id_kategori_produk')
        ->where('rb_kategori_produk.id_kategori_produk', '=', $id)
        ->get();
        return response()->json($subKategori);
    } 
}
