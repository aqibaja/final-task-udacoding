<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SubKategori extends Model 
{
    protected $table = "rb_kategori_produk_sub"; //name table di database
    //protected $fillable = ["id_kategori_produk", "nama_kategori", "kategori_seo", "gambar", "icon_kode" ,"icon_image", "urutan"];
    //protected $hidden = [];

    //query didalam sebuah method
    public function scopeWithid($query, $id){
        return $query->where('id_kategori_product', $id);
    }

    public function getName(){
        return $this->name_kategori;
    }

}