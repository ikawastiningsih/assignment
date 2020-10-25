class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :update, :destroy]

  # GET /schedules
  def index
    @keyword = params['keyword']
    data = []

    @list_schedules = Schedule.all.any_of({ :hari => /.*#{@keyword}.*/i}, { :jam_mulai => /.*#{@keyword}.*/i}, { :jam_selesai => /.*#{@keyword}.*/i})

    if @list_schedules.present?
      @list_schedules.each do |item|
        array = {
            id: item.id.to_s,
            doctor_id: item.doctor_id,
            hospital_id: item.hospital_id,
            hari: item.hari,
            jam_mulai: item.jam_mulai,
            jam_selesai: item.jam_selesai
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

  # GET /schedules/1
  def show
    render json: @schedule
  end

  # POST /schedules
  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      @return = {
        status: true, 
        message: "Berhasil Simpan Data", 
        content: @schedule,
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

  # PATCH/PUT /schedules/1
  def update
    if @schedule.update(schedule_params)
      render json: @schedule
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  # DELETE /schedules/1
  def destroy
    @schedule.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def schedule_params
      params.permit(:doctor_id, :hospital_id, :hari, :jam_mulai, :jam_selesai)
    end
end
