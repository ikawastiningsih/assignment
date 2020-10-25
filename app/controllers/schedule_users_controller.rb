class ScheduleUsersController < ApplicationController
  before_action :set_schedule_user, only: [:show, :update, :destroy]

  # GET /schedule_users
  def index
    @schedule_users = ScheduleUser.all

    render json: @schedule_users
  end

  # GET /schedule_users/1
  def show
    render json: @schedule_user
  end

  # POST /schedule_users
  def create
    schedule_id = params['schedule_id']

    cek_schedule = Schedule.find(schedule_id)['jam_mulai']
    convert_jam_mulai = cek_schedule.to_time - 30.minutes
    minimal_book = convert_jam_mulai.strftime("%H:%M")
    time_now = DateTime.now.strftime("%H:%M")

    if time_now < minimal_book
      cek_book_dokter = ScheduleUser.where(schedule_id: schedule_id).count
        if cek_book_dokter < 10
          @schedule_user = ScheduleUser.new(schedule_user_params)
          if @schedule_user.save
            @return = {
              status: false,
              message: "Pemesanan Berhasil", 
              content: @schedule_user, 
            }
          else
            @return = {
              status: false,
              message: "Mohon maaf, pemesanan tidak berhasil dilakukan!", 
              content: nil, 
            }  
          end
        else
          @return = {
            status: false,
            message: "Mohon maaf, pemesanan sudah maksimal!", 
            content: nil, 
          }  
        end
    else
      @return = {
        status: false,
        message: "Mohon maaf, jadwal pemesanan telah ditutup!", 
        content: nil, 
      } 
    end
    render json: @return
  end

  # PATCH/PUT /schedule_users/1
  def update
    if @schedule_user.update(schedule_user_params)
      render json: @schedule_user
    else
      render json: @schedule_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /schedule_users/1
  def destroy
    @schedule_user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule_user
      @schedule_user = ScheduleUser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def schedule_user_params
      params.permit(:user_id, :schedule_id, :nama_user, :keluhan)
    end
end
