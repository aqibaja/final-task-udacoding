part of 'konsumen_bloc.dart';

abstract class KonsumenEvent extends Equatable {
  const KonsumenEvent();

  @override
  List<Object> get props => [];
}

class ViewDetailEvent extends KonsumenEvent {
  final String idKonsumen;

  ViewDetailEvent({this.idKonsumen});
}

class EditDetailEvent extends KonsumenEvent {
  final int idKonsumen;
  final String username;
  final String password;
  final String namaLengkap;
  final String email;
  final String jenisKelamin;
  final String tanggalLahir;
  final String tempatLahir;
  final String alamatLengkap;
  final int kecamatanId;
  final int kotaId;
  final int provinsiId;
  final String noHp;
  final File foto;

  EditDetailEvent(
      {this.idKonsumen,
      this.alamatLengkap,
      this.email,
      this.foto,
      this.jenisKelamin,
      this.kecamatanId,
      this.kotaId,
      this.namaLengkap,
      this.noHp,
      this.password,
      this.provinsiId,
      this.tanggalLahir,
      this.tempatLahir,
      this.username});
}

class ClearEventKonsumen extends KonsumenEvent {}
