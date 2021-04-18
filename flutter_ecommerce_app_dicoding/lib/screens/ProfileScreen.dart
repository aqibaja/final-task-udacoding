import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/kecamatan_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/kota_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/provinsi_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_app/bloc/konsumen_bloc.dart';
import 'package:flutter_ecommerce_app/common_widget/CircularProgress.dart';
import 'package:flutter_ecommerce_app/models/DetailKonsumenModel.dart';
import 'package:flutter_ecommerce_app/models/KecamatanModel.dart';
import 'package:flutter_ecommerce_app/models/KotaModel.dart';
import 'package:flutter_ecommerce_app/models/provinsiModel.dart';
import 'package:flutter_ecommerce_app/screens/cobaAlamat.dart';
import 'package:flutter_ecommerce_app/utils/Urls.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class ProfileScreen extends StatefulWidget {
  final String saveId;
  ProfileScreen({this.saveId});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _datePicked;
  File _image; //variabel untuk menyimpan image sementara
  final picker = ImagePicker(); //objeck picker untuk mengambil image
  AuthBloc _bloc; // objeck bloc Auth
  KonsumenBloc _blocKonsumen; // objeck bloc Konsumen
  ProvinsiBloc _blocProvinsi;
  KotaBloc _blocKota;
  KecamatanBloc _blocKec;
  String _selectedProvinsi;
  String _selectedKota;
  String _selectedKecamatan;
  String provinsiSave;
  String kotaSave;
  String kecamatanSave;

  TextEditingController _textEditUsernam = TextEditingController();
  TextEditingController _textEditFullName = TextEditingController();
  TextEditingController _textEditEmail = TextEditingController();
  TextEditingController _textEditGender = TextEditingController();
  TextEditingController _textEditTempatLahir = TextEditingController();
  TextEditingController _textEditNoHp = TextEditingController();
  TextEditingController _textEditAlamatPengiriman = TextEditingController();
  TextEditingController _textEditDate = TextEditingController(
      /* text: _date.day.toString() +
          " / " +
          _date.month.toString() +
          " / " +
          _date.year.toString(), */
      );

  //method menyambil image di camera
  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //method menyambil image di galery
  Future getImageGalery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<Null> selectedTimePicker(BuildContext context) async {
    DateTime _date = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(_date);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        _datePicked = formatted;
        print(formatted);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AuthBloc>(context);
    _blocProvinsi = BlocProvider.of<ProvinsiBloc>(context);
    _blocKota = BlocProvider.of<KotaBloc>(context);
    _blocKec = BlocProvider.of<KecamatanBloc>(context);
    _blocKonsumen = BlocProvider.of<KonsumenBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is SignInOut) {
            _blocKonsumen.add(ClearEventKonsumen());
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('LogOut...'),
                duration: const Duration(seconds: 1),
              ));
            });
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pop(context);
            });
          }
          return BlocBuilder<KonsumenBloc, KonsumenState>(
            builder: (context, state) {
              if (state is KonsumenInitial) {
                _blocKonsumen.add(ViewDetailEvent(idKonsumen: widget.saveId));
              }
              if (state is KonsumenLoading) {
                return JumpingDotsProgressIndicator(
                  fontSize: 50.0.sp,
                );
                //return CircularProgress();
              }
              if (state is KonsumenSuccess) {
                /* _blocProvinsi.add(ClearEventProvinsi());
                _blocKota.add(ClearEventKota()); */
                DetailKonsumenModel detail = state.konsumenModel;
                print(detail.data.provinceName);
                _textEditUsernam.text = detail.data.username;
                _textEditFullName.text = detail.data.namaLengkap;
                _textEditGender.text = detail.data.jenisKelamin;
                _textEditEmail.text = detail.data.email;
                _textEditNoHp.text = detail.data.noHp;
                _textEditDate.text = detail.data.tanggalLahir;
                _textEditTempatLahir.text = detail.data.tempatLahir;
                _textEditAlamatPengiriman.text = detail.data.alamatLengkap;
                _datePicked != null
                    ? _textEditDate.text = _datePicked
                    : _textEditDate.text = detail.data.tanggalLahir;

                return Container(
                  margin: EdgeInsets.only(right: 5.0.w, left: 5.0.w),
                  child: Center(
                      child: Column(
                    children: [
                      image(detail.data.foto),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buttonSelect("Galery"),
                          buttonSelect("Camera"),
                        ],
                      ),
                      textField("Username", Icons.person, 1, _textEditUsernam),
                      textField("Nama Lengkap", Icons.person_search, 1,
                          _textEditFullName),
                      textField("Kelamin", FontAwesomeIcons.venusMars, 1,
                          _textEditGender),
                      textField("Email", Icons.mail, 1, _textEditEmail),
                      textField("No Hp", Icons.phone, 1, _textEditNoHp),
                      textField(
                          "tempat Lahir", Icons.home, 1, _textEditTempatLahir),
                      datePickerTextField(
                          "Tanggal Lahir", Icons.date_range, _textEditDate),
                      textField("Alamat Pengiriman", FontAwesomeIcons.idCard, 3,
                          _textEditAlamatPengiriman),
                      BlocBuilder<ProvinsiBloc, ProvinsiState>(
                        builder: (context, state) {
                          List dataModel;
                          String stateHint = detail.data.provinceName;
                          provinsiSave = detail.data.provinsiId.toString();
                          String hint = "Pilih provinsi";
                          if (state is AlamatInitial) {
                            _blocProvinsi.add(ViewProvinsiEvent());
                          }
                          if (state is ProvinsiLoading) {
                            return dropDownProvinsi(
                                "provinsi",
                                Icons.home,
                                dataModel,
                                stateHint != null ? stateHint : hint,
                                true);
                          }
                          if (state is ProvinsiSuccess) {
                            List<ProvinsiModel> data = state.provinsiModel;
                            String stateHint = detail.data.provinceName;
                            return dropDownProvinsi(
                                "provinsi",
                                Icons.home,
                                data,
                                stateHint != null ? stateHint : hint,
                                false);
                          }
                          return dropDownProvinsi(
                              "provinsi",
                              Icons.home,
                              dataModel,
                              stateHint != null ? stateHint : hint,
                              false);
                        },
                      ),
                      BlocBuilder<KotaBloc, KotaState>(
                        builder: (context, state) {
                          List dataModel;
                          String stateHint = detail.data.cityName;
                          kotaSave = detail.data.cityId.toString();
                          String hint = "Pilih kota";
                          if (state is KotaInitial) {
                            print("initial bloc kota");
                          }
                          if (state is KotaLoading) {
                            print("loadingKota");
                            //showProgressDialog();
                            return dropDownKota(
                                "Kota",
                                Icons.home_work_outlined,
                                dataModel,
                                stateHint != null ? stateHint : hint,
                                true);
                          }
                          if (state is KotaSuccess) {
                            //dismissProgressDialog();
                            List<KotaModel> data = state.kotaModel;
                            String stateHint = detail.data.cityName;
                            return dropDownKota(
                                "Kota",
                                Icons.home_work_outlined,
                                data,
                                stateHint != null ? stateHint : hint,
                                false);
                          }
                          return dropDownKota(
                              "Kota",
                              Icons.home_work_outlined,
                              dataModel,
                              stateHint != null ? stateHint : hint,
                              false);
                        },
                      ),
                      BlocBuilder<KecamatanBloc, KecamatanState>(
                          builder: (context, state) {
                        List dataModel;
                        String stateHint = detail.data.subdistrictName;
                        kecamatanSave = detail.data.subdistrictId.toString();
                        String hint = "Pilih kecamatan";
                        if (state is KecamatanInitial) {
                          print("initial bloc kecamatan");
                        }
                        if (state is KecamatanLoading) {
                          print("loading Kecamatan");
                          return dropDownKecamatan(
                              "Kecamatan",
                              Icons.house_rounded,
                              dataModel,
                              stateHint != null ? stateHint : hint,
                              true);
                        }
                        if (state is KecamatanSuccess) {
                          List<KecamatanModel> data = state.kecamatanModel;
                          String stateHint = detail.data.subdistrictName;
                          return dropDownKecamatan(
                              "Kecamatan",
                              Icons.house_rounded,
                              data,
                              stateHint != null ? stateHint : hint,
                              false);
                        }
                        return dropDownKecamatan(
                            "Kecamatan",
                            Icons.house_rounded,
                            dataModel,
                            stateHint != null ? stateHint : hint,
                            false);
                      }),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildElevatedButton("Save", Colors.lightGreen, 1),
                          SizedBox(
                            width: 3.0.w,
                          ),
                          buildElevatedButton("Logout", Colors.redAccent, 2)
                        ],
                      ),
                    ],
                  )),
                );
              }
              if (state is KonsumenEditLoading) {
                print("loading!!!!!");
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Sedang diproses...'),
                    duration: const Duration(seconds: 1),
                  ));
                });
                return JumpingDotsProgressIndicator(
                  fontSize: 50.0.sp,
                );
              }
              if (state is KonsumenEditSuccess) {
                print(state.konsumenEditModel.message);
                _blocKonsumen.add(ViewDetailEvent(idKonsumen: widget.saveId));
              }
              if (state is KonsumenEditError) {
                //pr.hide();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Gagal, terjadi kesalahan'),
                    duration: const Duration(seconds: 1),
                  ));
                });
              }
              return Container();
            },
          );
        })));
    /*    }); */
  }

  Widget dropDownProvinsi(
      String title, IconData icon, List dataModel, String hint, bool loading) {
    List<ProvinsiModel> dataProv;
    List<DropdownMenuItem<String>> dataItem = [
/*       DropdownMenuItem<String>(
        value: "Belum ada data",
        child: Text(
          "Belum ada data",
        ),
      ), */
    ];
    if (dataModel != null) {
      dataProv = dataModel;
      for (int i = 0; i < dataProv.length; i++) {
        dataItem.add(DropdownMenuItem<String>(
            value: dataProv[i].provinceId.toString(),
            child: Text(
              dataProv[i].provinceName,
            )));
      }
    }

    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
        primaryColorDark: Colors.red,
      ),
      child: Container(
        child: DropdownButtonFormField<String>(
            items: dataItem,
            onChanged: (value) async {
              setState(() {
                _selectedProvinsi = value;
                /* for (int i = 0; i < dataProv.length; i++) {
                  if (value == dataProv[i].provinceId.toString()) {
                    _selectedProvinsi = dataProv[i].provinceName;
                  }
                } */
                _selectedKota = null;
                _selectedKecamatan = null;
                _blocKota.add(ViewKotaEvent(provinsiId: value));
              });
            },
            value: _selectedProvinsi,
            hint: (loading != true)
                ? Text(
                    hint,
                    style: TextStyle(
                      fontSize: 13.0.sp,
                      color: Colors.black,
                    ),
                  )
                : JumpingDotsProgressIndicator(
                    fontSize: 20.0,
                  ),
            /* validator: (value) =>
                value == null ? 'Silahkan Pilih' + title : null, */
            decoration: InputDecoration(
                /* labelText: title, */
                hintStyle: TextStyle(color: Colors.black),
                labelStyle: TextStyle(fontSize: 17.0.sp),
                //prefixIcon: Icon(Icons.email),
                icon: Icon(
                  icon,
                  size: 7.0.w,
                )),
            elevation: 2,
            style: TextStyle(color: Colors.black, fontSize: 16),
            isDense: true,
            iconSize: 30.0,
            iconDisabledColor: Colors.black,
            iconEnabledColor: Colors.black),
      ),
    );
  }

  Widget dropDownKota(
      String title, IconData icon, List dataModel, String hint, bool loading) {
    List<KotaModel> dataKota;
    List<DropdownMenuItem<String>> dataItem = [
/*       DropdownMenuItem<String>(
        value: "Belum ada data",
        child: Text(
          "Belum ada data",
        ),
      ), */
    ];
    if (dataModel != null) {
      dataKota = dataModel;
      for (int i = 0; i < dataKota.length; i++) {
        dataItem.add(DropdownMenuItem<String>(
            value: dataKota[i].cityId.toString(),
            child: Text(
              dataKota[i].cityName,
            )));
      }
    }

    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
        primaryColorDark: Colors.red,
      ),
      child: Container(
        child: DropdownButtonFormField<String>(
            items: dataItem,
            onChanged: (value) async {
              setState(() {
                _selectedKota = value;
                /* for (int i = 0; i < dataProv.length; i++) {
                  if (value == dataProv[i].provinceId.toString()) {
                    _selectedProvinsi = dataProv[i].provinceName;
                  }
                } */
                _selectedKecamatan = null;
                _blocKec.add(ViewKecamatanEvent(kotaId: value));
              });
            },
            value: _selectedKota,
            hint: (loading != true)
                ? Text(
                    hint,
                    style: TextStyle(
                      fontSize: 13.0.sp,
                      color: Colors.black,
                    ),
                  )
                : JumpingDotsProgressIndicator(
                    fontSize: 20.0,
                  ),
            /* validator: (value) =>
                value == null ? 'Silahkan Pilih' + title : null, */
            decoration: InputDecoration(
                //labelText: title,
                //labelStyle: TextStyle(fontSize: 17.0.sp),
                //prefixIcon: Icon(Icons.email),
                icon: Icon(
              icon,
              size: 7.0.w,
            )),
            elevation: 2,
            style: TextStyle(color: Colors.black, fontSize: 16),
            isDense: true,
            iconSize: 30.0,
            iconDisabledColor: Colors.black,
            iconEnabledColor: Colors.black),
      ),
    );
  }

  Widget dropDownKecamatan(
      String title, IconData icon, List dataModel, String hint, bool loading) {
    List<KecamatanModel> dataKec;
    List<DropdownMenuItem<String>> dataItem = [
/*       DropdownMenuItem<String>(
        value: "Belum ada data",
        child: Text(
          "Belum ada data",
        ),
      ), */
    ];
    if (dataModel != null) {
      dataKec = dataModel;
      for (int i = 0; i < dataKec.length; i++) {
        dataItem.add(DropdownMenuItem<String>(
            value: dataKec[i].subdistrictId.toString(),
            child: Text(
              dataKec[i].subdistrictName,
            )));
      }
    }

    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
        primaryColorDark: Colors.red,
      ),
      child: Container(
        child: DropdownButtonFormField<String>(
            items: dataItem,
            onChanged: (value) async {
              setState(() {
                _selectedKecamatan = value;
              });
            },
            value: _selectedKecamatan,
            hint: (loading != true)
                ? Text(
                    hint,
                    style: TextStyle(
                      fontSize: 13.0.sp,
                      color: Colors.black,
                    ),
                  )
                : JumpingDotsProgressIndicator(
                    fontSize: 20.0,
                  ),
            /* validator: (value) =>
                value == null ? 'Silahkan Pilih' + title : null, */
            decoration: InputDecoration(
                /* labelText: title,
                labelStyle: TextStyle(fontSize: 17.0.sp), */
                //prefixIcon: Icon(Icons.email),
                icon: Icon(
              icon,
              size: 7.0.w,
            )),
            elevation: 2,
            style: TextStyle(color: Colors.black, fontSize: 16),
            isDense: true,
            iconSize: 30.0,
            iconDisabledColor: Colors.black,
            iconEnabledColor: Colors.black),
      ),
    );
  }

  //tombol save dan logout
  ElevatedButton buildElevatedButton(String text, Color primary, int number) {
    return ElevatedButton(
      onPressed: () {
        number == 1
            ? _blocKonsumen.add(EditDetailEvent(
                idKonsumen: int.parse(widget.saveId),
                namaLengkap: _textEditFullName.text,
                email: _textEditEmail.text,
                alamatLengkap: _textEditAlamatPengiriman.text,
                jenisKelamin: _textEditGender.text,
                noHp: _textEditNoHp.text,
                tanggalLahir:
                    _datePicked != null ? _datePicked : _textEditDate.text,
                tempatLahir: _textEditTempatLahir.text,
                username: _textEditUsernam.text,
                foto: _image,
                provinsiId: _selectedProvinsi == null
                    ? int.parse(provinsiSave)
                    : int.parse(_selectedProvinsi),
                kotaId: _selectedKota == null
                    ? int.parse(kotaSave)
                    : int.parse(_selectedKota),
                kecamatanId: _selectedKecamatan == null
                    ? int.parse(kecamatanSave)
                    : int.parse(_selectedKecamatan)))
            : _bloc.add(LogOutEvent());
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: primary, // background
        onPrimary: Colors.white, // foreground
      ),
    );
  }

  //lokasi
  Widget locationPicker(
      String label, IconData icon, TextEditingController _textEditLocation) {
    return Container(
      margin: EdgeInsets.only(left: 1.0.w),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: _textEditLocation,
              // focusNode: _passwordEmail,
              //keyboardType: TextInputType.emailAddress,
              //textInputAction: TextInputAction.next,
              //validator: _validateEmail,
              onFieldSubmitted: (String value) {
                //FocusScope.of(context).requestFocus(_passwordFocus);
              },
              decoration: InputDecoration(
                  labelText: label,
                  //prefixIcon: Icon(Icons.email),
                  icon: Icon(
                    icon,
                    size: 7.0.w,
                  )),
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                selectedTimePicker(context);
              },
              child: Text("Pilih Lokasi"),
            ),
          )
        ],
      ),
    );
  }

  //mengambil tanggal
  Widget datePickerTextField(
      String label, IconData icon, TextEditingController _textEditDate) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
        primaryColorDark: Colors.red,
      ),
      child: Container(
        margin: EdgeInsets.only(left: 1.0.w),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: _textEditDate,
                // focusNode: _passwordEmail,
                //keyboardType: TextInputType.emailAddress,
                //textInputAction: TextInputAction.next,
                //validator: _validateEmail,
                onFieldSubmitted: (String value) {
                  //FocusScope.of(context).requestFocus(_passwordFocus);
                },
                decoration: InputDecoration(
                    labelText: label,
                    labelStyle: TextStyle(fontSize: 17.0.sp),
                    //prefixIcon: Icon(Icons.email),
                    icon: Icon(
                      icon,
                      size: 7.0.w,
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  selectedTimePicker(context);
                },
                child: Text("Pilih Tanggal"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textField(String label, IconData icon, int maxLine,
      TextEditingController _textEdit) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
        primaryColorDark: Colors.red,
      ),
      child: Container(
        margin: EdgeInsets.only(left: 1.0.w),
        child: TextFormField(
          controller: _textEdit,
          //controller: _textEditConEmail,
          // focusNode: _passwordEmail,
          // keyboardType: TextInputType.emailAddress,
          // textInputAction: TextInputAction.next,
          //validator: _validateEmail,
          onFieldSubmitted: (String value) {
            //FocusScope.of(context).requestFocus(_passwordFocus);
          },
          maxLines: maxLine,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(fontSize: 17.0.sp),

              //prefixIcon: Icon(Icons.email),
              icon: Icon(
                icon,
                size: 7.0.w,
              )),
        ),
      ),
    );
  }

  //pilih galery atau camera
  Widget buttonSelect(String from) {
    return Container(
      margin: EdgeInsets.only(top: 1.0.h, right: 1.0.h, left: 1.0.h),
      child: RaisedButton(
        onPressed: () {
          from == "Camera" ? getImageCamera() : getImageGalery();
        },
        child: Text(from),
      ),
    );
  }

  Container image(String foto) {
    return Container(
      margin: EdgeInsets.only(top: 5.0.h),
      width: 45.0.w,
      height: 21.0.h,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 5)),
      child: (_image == null)
          ? Image.network(
              Urls.ROOT_URL + foto,
              fit: BoxFit.fill,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace stackTrace) {
                // Appropriate logging or analytics, e.g.
                // myAnalytics.recordError(
                //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                //   exception,
                //   stackTrace,
                // );
                return Image.asset(
                  "assets/images/no-image.png",
                  fit: BoxFit.fill,
                );
              },
            )
          : Image.file(
              _image,
              height: 35.0.w,
              width: 35.0.w,
              fit: BoxFit.fill,
            ),
    );
  }
}
