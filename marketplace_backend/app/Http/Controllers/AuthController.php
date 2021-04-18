<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
Use Exception;

class AuthController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function register(Request $request)
    {
       $usename = $request->input('username');
       $email = $request->input('email');
       $gender = $request->input('jenis_kelamin');
       $phone= $request->input('no_hp');
       $password = Hash::make($request->input('password'));
       $inputPass = $request->input('password');
       $passSha512 = hash("sha512",$inputPass);

       $user = DB::table('rb_konsumen')->where('email',$email)->first();

       if($user == false){
        $register = DB::table('rb_konsumen')->insert([
            'username' => $usename,
            'email' => $email,
            'password' => $passSha512,
            'jenis_kelamin' => $gender,
            'no_hp' =>$phone
        ]);
        if($register){
            return response()->json([
                'success' => "true",
                'message' => 'Register Success!',
                'data' => "berhasil"
            ], 201);
       } else {
        return response()->json([
            'success' => "false",
            'message' => 'Register fail!',
            'data' => ''
        ], 400);
       }
       } else {
        return response()->json([
            'success' => "false",
            'message' => 'Email Sudah Terdaftar',
            'data' => ''
        ], 400);
       }

       
       
    }

    public function login(Request $request)
    {
       $email = $request->input('email');
       $password = $request->input('password');
       $inputPass = $request->input('password');
       $passSha512 = hash("sha512",$inputPass);

       $user = DB::table('rb_konsumen')
       ->where('email',$email)
       ->orWhere('username', $email)
       ->orWhere('no_hp', $email)
       ->first();
        
       $checkPass = $user->password;

       try
    {
        if ($checkPass == $passSha512){
           
            //$apiToken = base64_encode(Str::random(40));

            //tambah token / session jika perlu
           /* DB::table('rb_konsumen')->where('email',$email)->update([
                'api_token' => $apiToken
           ]); */

           return response()->json([
            'success' => true,
            'message' => 'Login Success!',
            'data' => [
                'user' => $user,            ]
            ], 201);
       } else {
        return response()->json([
            'success' => false,
            'message' => 'Login fail!'
        ], 400);
    }
    }
        catch(Exception $e)
    {
        return response()->json([
            'success' => false,
            'message' => 'Data yang anda masukkan tidak benar!'
        ], 400);
    }

    }
  
}
