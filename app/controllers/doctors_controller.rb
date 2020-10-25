class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :update, :destroy]

  # GET /doctors
  def index
    @keyword = params['keyword']
    data = []

    @list_doctors = Doctor.all.any_of({ :nama => /.*#{@keyword}.*/i}, { :nohp => /.*#{@keyword}.*/i}, { :spesialis => /.*#{@keyword}.*/i})

    if @list_doctors.present?
      @list_doctors.each do |item|
        array = {
            id: item.id.to_s,
            nama: item.nama,
            no_handpone: item.nohp,
            email: item.email,
            jenis_kelamin: item.jenis_kelamin,
            spesialis: item.spesialis,
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

  # GET /doctors/1
  def show
    render json: @doctor
  end

  # POST /doctors
  def create
    @doctor = Doctor.new(doctor_params)

    if @doctor.save
      @return = {
        status: true, 
        message: "Berhasil Simpan Data", 
        content: @doctor,
      }
    else
      @return = {
        status: false,
        message: "Mohon maaf, Data tidak berhasil di simpan", 
        content: nil, 
      }
    end
    render json: @return
  end

  # PATCH/PUT /doctors/1
  def update
    if @doctor.update(doctor_params)
      render json: @doctor
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /doctors/1
  def destroy
    @doctor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def doctor_params
      params.permit(:nama, :nohp, :email, :jenis_kelamin, :spesialis)
    end
end
