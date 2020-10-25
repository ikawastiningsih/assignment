class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

   # POST /users/auth
  def auth
    username = params['username']
    password = params['password']
    data = []

    user = User.where(username: username)
    password_en = M2encryptorHelper.encryption(password)

    if user.present?
      if user[0]['password'] == password_en
        user.each do |item|
          array = {
            id: item.id.to_s,
            nama: item.nama,
            no_handpone: item.nohp,
            email: item.email,
            jenis_kelamin: item.jenis_kelamin,
            tempat_lahir: item.tempat_lahir,
            tanggal_lahir: item.tanggal_lahir,
            username: item.username,
            password: item.password\
        }
        data.push(array)
        end
        @return = {
          status: true, 
          message: "Data Ditemukan", 
          content: data,
        }
      else
        @return = {
          status: false,
          message: "Mohon maaf, anda salah memasukkan Password!", 
          content: nil, 
        }
      end
    else
      @return = {
        status: false,
        message: "Mohon maaf, Anda belum terdaftar!", 
        content: nil, 
      }
    end   
    render json: @return
  end

  # GET /users
  def index
    @keyword = params['keyword']
    data = []

    @list_users = User.all.any_of({ :username => /.*#{@keyword}.*/i}, { :nama => /.*#{@keyword}.*/i}, { :nohp => /.*#{@keyword}.*/i})

    if @list_users.present?
      @list_users.each do |item|
        array = {
            id: item.id.to_s,
            nama: item.nama,
            no_handpone: item.nohp,
            email: item.email,
            jenis_kelamin: item.jenis_kelamin,
            tempat_lahir: item.tempat_lahir,
            tanggal_lahir: item.tanggal_lahir,
            username: item.username,
            password: item.password\
        }
        data.push(array)
      end
        @return = {
          status: true, 
          message: "Data Ditemukan", 
          content: data,
        }
    else
      @return = {
        status: false,
        message: "Mohon maaf, Data tidak Ditemukan!", 
        content: nil, 
      }
    end
    render json: @return
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    username = params['username']
    password = params['password']

    cek_username = User.find_by(username: username)
    password_en = M2encryptorHelper.encryption(password)
    if !cek_username.present?
      data = {
        nama: params['nama'],
        nohp: params['nohp'],
        email: params['email'],
        jenis_kelamin: params['jenis_kelamin'],
        tempat_lahir: params['tempat_lahir'],
        tanggal_lahir: params['tanggal_lahir'],
        username: params['username'],
        password: password_en
      }
      @user = User.new(data)
        if @user.save
          @return = {
            status: true, 
            message: "Berhasil Simpan Data", 
            content: @user,
          }
        else
          @return = {
            status: false,
            message: "Mohon maaf, Data tidak berhasil di simpan", 
            content: nil, 
          }
        end
    else
      @return = {
        status: false, 
        message: "Username sudah Digunakan!! Harap masukkan username lain", 
        content: @user,
      }
    end
    render json: @return
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:nama, :jenis_kelamin, :nohp, :email, :tempat_lahir, :tanggal_lahir, :username, :password)
    end
end
