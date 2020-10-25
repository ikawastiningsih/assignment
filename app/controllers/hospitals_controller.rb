class HospitalsController < ApplicationController
  before_action :set_hospital, only: [:show, :update, :destroy]

  # GET /hospitals
  def index
    @keyword = params['keyword']
    data = []

    @list_hospitals = Hospital.all.any_of({ :nama => /.*#{@keyword}.*/i}, { :alamat => /.*#{@keyword}.*/i}, { :notelp => /.*#{@keyword}.*/i})

    if @list_hospitals.present?
      @list_hospitals.each do |item|
        array = {
            id: item.id.to_s,
            nama: item.nama,
            no_telephone: item.notelp,
            alamat: item.alamat
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

  # GET /hospitals/1
  def show
    render json: @hospital
  end

  # POST /hospitals
  def create
    @hospital = Hospital.new(hospital_params)

    if @hospital.save
      @return = {
        status: true, 
        message: "Berhasil Simpan Data", 
        content: @hospital,
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

  # PATCH/PUT /hospitals/1
  def update
    if @hospital.update(hospital_params)
      render json: @hospital
    else
      render json: @hospital.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hospitals/1
  def destroy
    @hospital.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hospital
      @hospital = Hospital.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hospital_params
      params.permit(:nama, :alamat, :notelp)
    end
end
