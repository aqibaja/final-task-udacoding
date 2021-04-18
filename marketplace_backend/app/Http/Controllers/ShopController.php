<?php

namespace App\Http\Controllers;

use App\Models\Shop; // model database
use Illuminate\Http\Request;

class ShopController extends Controller
{
    public function showAllShop()
    {
        return response()->json(Shop::all());
    }

    public function showOneShop($id)
    {
        return response()->json(Shop::find($id));
    }

    public function create(Request $request)
    {
        $author = Shop::create($request->all());

        return response()->json($author, 201);
    }

    public function update($id, Request $request)
    {
        $author = Shop::findOrFail($id);
        $author->update($request->all());

        return response()->json($author, 200);
    }

    public function delete($id)
    {
        Shop::findOrFail($id)->delete();
        return response('Deleted Successfully', 200);
    }
}
