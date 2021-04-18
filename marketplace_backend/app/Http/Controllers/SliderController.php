<?php

namespace App\Http\Controllers;

use App\Models\Slider; // model database
use Illuminate\Http\Request;

class SliderController extends Controller
{
    public function showAllSlider()
    {
        return response()->json(Slider::all());
    }

    public function showOneSlider($id)
    {
        return response()->json(Slider::find($id));
    }

    public function create(Request $request)
    {
        $author = Slider::create($request->all());

        return response()->json($author, 201);
    }

    public function update($id, Request $request)
    {
        $author = Slider::findOrFail($id);
        $author->update($request->all());

        return response()->json($author, 200);
    }

    public function delete($id)
    {
        Slider::findOrFail($id)->delete();
        return response('Deleted Successfully', 200);
    }
}
