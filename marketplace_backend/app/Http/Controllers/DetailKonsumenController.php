<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
Use Exception;

class DetailKonsumenController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function showAllDetailKonsumen(Request $request)
    {
       $idKonsumen = $request->input('id_konsumen');
      

       $user = DB::table('rb_konsumen')
       ->leftjoin('tb_ro_provinces', 'rb_konsumen.provinsi_id', '=', 'tb_ro_provinces.province_id')
       ->leftjoin('tb_ro_cities', 'rb_konsumen.kota_id', '=', 'tb_ro_cities.city_id')
       ->leftjoin('tb_ro_subdistricts', 'rb_konsumen.kecamatan_id', '=', 'tb_ro_subdistricts.subdistrict_id')
       ->where('id_konsumen',$idKonsumen)->first();

        if($user){
            return response()->json([
                'success' => "true",
                'message' => 'Success!',
                'data' => $user
            ], 201);
       } else {
        return response()->json([
            'success' => "false",
            'message' => 'View Detail Konsumen fail!',
        ], 400);
    } 
    }

    public function uploadAllDetailKonsumen(Request $request)
    {
        $idKonsumen = $request->input('id_konsumen');
        $avatar = Str::random(34);
        $request->file('foto')->move(storage_path('foto'), $avatar);

        $user_profile = DB::table('rb_konsumen')->where('id_konsumen',$idKonsumen)->first();

        if ($user_profile) {
          $current_avatar_path = storage_path('foto') . '/' . $user_profile->foto;
          if (file_exists($current_avatar_path)) {
            unlink($current_avatar_path);
          }
        $user_profile->foto = $avatar;
          /* $user_profile->first_name = $request->first_name;
          $user_profile->last_name = $request->last_name; */
          $user_profile->save();
        }else{
          /* $user_profile = new UserProfile;
          $user_profile->user_id = Auth::user()->id;
          $user_profile->avatar = $avatar;
          $user_profile->first_name = $request->first_name;
          $user_profile->last_name = $request->last_name;
          $user_profile->save(); */
          return "terjadi kesalahan";
        }
        $res['success'] = true;
        $res['message'] = "Success update user profile.";
        $res['data'] = $user_profile;
        return response()->json($res, 200);
       
    }

    //fungsi upload data dan image
    public function uploadImage(Request $request)
    {
        $idKonsumen = $request->input('id_konsumen');
        $nama_lengkap = $request->input('nama_lengkap');
        $username = $request->input('username');
        $email = $request->input('email');
        $jenis_kelamin = $request->input('jenis_kelamin');
        $tanggal_lahir = $request->input('tanggal_lahir');
        $tempat_lahir= $request->input('tempat_lahir');
        $alamat_lengkap= $request->input('alamat_lengkap');
        $no_hp= $request->input('no_hp');
        $kecamatan_id= $request->input('kecamatan_id');
        $kota_id= $request->input('kota_id');
        $provinsi_id= $request->input('provinsi_id');


        $user_profile = DB::table('rb_konsumen')->where('id_konsumen',$idKonsumen)->first();
        //$user = (object) ['image' => ""];

        if ($request->hasFile('image')) {
            $original_filename = $request->file('image')->getClientOriginalName();
            $original_filename_arr = explode('.', $original_filename);
            $file_ext = end($original_filename_arr);
            $destination_path = './upload/user/';
            $image = 'U-' . time() . '.' . $file_ext;

            if ($request->file('image')->move($destination_path, $image)) {
                //$user_profile ->foto= '/upload/user/' . $image;
                DB::table('rb_konsumen')->where('id_konsumen', $idKonsumen)->update(
                    ['foto' => '/upload/user/' . $image, 
                    'id_konsumen' => $idKonsumen,
                    'nama_lengkap' => $nama_lengkap,
                    'username' => $username,
                    'email' => $email,
                    'jenis_kelamin' => $jenis_kelamin,
                    'tanggal_lahir' => $tanggal_lahir,
                    'tempat_lahir' => $tempat_lahir,
                    'alamat_lengkap' => $alamat_lengkap,
                    'no_hp' => $no_hp,
                    'kecamatan_id' => $kecamatan_id,
                    'kota_id'   => $kota_id,
                    'provinsi_id' => $provinsi_id,
                    ]
                
                );
                $user_profile2 = DB::table('rb_konsumen')->where('id_konsumen',$idKonsumen)->first();
                return $this->responseRequestSuccess($user_profile2);
            } else {
                return $this->responseRequestError('Cannot upload file');
            }
        } else if ($user_profile ) {
            //$user_p$user_profilerofile ->foto= '/upload/user/' . $image;
            DB::table('rb_konsumen')->where('id_konsumen', $idKonsumen)->update(
                ['id_konsumen' => $idKonsumen,
                'nama_lengkap' => $nama_lengkap,
                'username' => $username,
                'email' => $email,
                'jenis_kelamin' => $jenis_kelamin,
                'tanggal_lahir' => $tanggal_lahir,
                'tempat_lahir' => $tempat_lahir,
                'alamat_lengkap' => $alamat_lengkap,
                'no_hp' => $no_hp,
                'kecamatan_id' => $kecamatan_id,
                'kota_id'   => $kota_id,
                'provinsi_id' => $provinsi_id,
                ]
            
            );
            $user_profile2 = DB::table('rb_konsumen')->where('id_konsumen',$idKonsumen)->first();
            return $this->responseRequestSuccess($user_profile2);
        } 
        else {
            
            return $this->responseRequestError('File not found');
        }
    }

    protected function responseRequestSuccess($ret)
    {
        return response()->json(['success' => "true",'message' => 'Success!'], 200)
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
