<?php
use Illuminate\Support\Str;

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

//utama
$router->get('/', function () use ($router) {
    return $router->app->version();
});

//mengambil key app
$router->get('/key', function(){
    $key = Str::random(32);
    return $key;
});

//rest api
$router->group(['prefix' => 'api'], function () use ($router) {

    //register
    $router->post('register', ['uses' => 'AuthController@register']);

    //login
    $router->post('login', ['uses' => 'AuthController@login']);

    //mengambil kategori dari database
    $router->get('kategori',  ['uses' => 'KategoriController@showAllKategori']);
  
    $router->get('kategori/{id}', ['uses' => 'KategoriController@showOneKategori']);
  
    $router->post('kategori', ['uses' => 'KategoriController@create']);
  
    $router->delete('kategori/{id}', ['uses' => 'KategoriController@delete']);
  
    $router->put('kategori/{id}', ['uses' => 'KategoriController@update']);

    //mengambil product berdasarkan kategori saja
    $router->get('kategori-and-product/{id}',  ['uses' => 'KategoriController@showAllKategoriAndProduct']);

    //mengambil shop atau penjual dari database
    $router->get('shop',  ['uses' => 'ShopController@showAllShop']);

     //mengambil image slider dari database
     $router->get('slider',  ['uses' => 'SliderController@showAllSlider']);



     //mengambil sub kategori dari database
     $router->get('sub-kategori',  ['uses' => 'SubKategoriController@showAllSubKategori']);
     $router->get('sub-kategori-and-product/{id}',  ['uses' => 'SubKategoriController@showAllSubKategoriAndProduct']);
     $router->get('sub-kategori/{id}', ['uses' => 'SubKategoriController@showSpecificSubKategori']);

     //mengambil product dari database
     $router->get('product',  ['uses' => 'ProductController@showAllSubProduct']);
     $router->get('product/{id}', ['uses' => 'ProductController@showSpecificProduct']); // menurut id_product
     $router->get('product_by_sub_kategori/{id}', ['uses' => 'ProductController@showKategoriProduct']); // menurut kategori
     $router->get('product_all_join/{id}', ['uses' => 'ProductController@joinProductVariasiDiskon']);
     $router->get('product_review/{id}', ['uses' => 'ProductController@showUlasan']);
     $router->get('product-terpopuler',  ['uses' => 'ProductController@showAllPoductPopular']);
     $router->get('product-diskon-terbaru',  ['uses' => 'ProductController@showAllPoductDiskon']);
     $router->post('product-check-favorite',  ['uses' => 'ProductController@checkFavorite']);
     $router->post('product-add-favorite',  ['uses' => 'ProductController@addFavorite']);
     $router->post('product-delete-favorite',  ['uses' => 'ProductController@deleteFavorite']);
     $router->post('product-list-favorite',  ['uses' => 'ProductController@listFavorite']);
     
     //cart
     $router->post('product-add-cart',  ['uses' => 'ProductController@addCart']);
     $router->post('product-delete-cart',  ['uses' => 'ProductController@deleteCart']);
     $router->post('product-list-cart',  ['uses' => 'ProductController@listCart']);
     $router->post('product-add-total-cart',  ['uses' => 'ProductController@addTotalCart']);
     $router->post('product-remove-total-cart',  ['uses' => 'ProductController@removeTotalCart']);

     //mengambil detail user dari database
     $router->post('detail-konsumen',  ['uses' => 'DetailKonsumenController@showAllDetailKonsumen']);

     //upload detail user ke database
     $router->post('upload-konsumen',  ['uses' => 'DetailKonsumenController@uploadImage']);

     //all provinsi
     $router->get('detail-provinsi',  ['uses' => 'DetailAlamatController@getProvinsi']);
     //all kota
     $router->post('detail-kota',  ['uses' => 'DetailAlamatController@getKota']);
      //all kecamatan
    $router->post('detail-kecamatan',  ['uses' => 'DetailAlamatController@getKec']);

    // MY SHOP
    $router->post('check-shop',  ['uses' => 'MyShopController@checkShop']);
    $router->post('create-shop',  ['uses' => 'MyShopController@createShop']);

     // WISH LIST
     $router->post('check-wish-list',  ['uses' => 'WishListController@checkWish']);

  });