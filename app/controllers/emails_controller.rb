class EmailsController < ApplicationController
  before_action :set_person
  before_action :set_email, only: [:show, :update, :destroy]

  def create
    @email = @person.emails.build(email_params)
    if @email.save
      render json: @email, status: :created
    else
      render json: @email.errors, status: :unprocessable_entity
    end
  end

  def show; end

  def update
    if @email.update(email_params)
      render json: @email
    else
      render json: @email.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @email.destroy
  end

  private

  def set_person
    @person = Person.find_by(id: params[:people_id])
    render json: {error: 'Unable to find user'}, status: :unprocessable_entity if @person.nil?
  end

  def set_email
    @email = @person.emails.find_by(id: params[:id])
    render json: {error: 'Unable to find this email'}, status: :unprocessable_entity if @email.nil?
  end

  def email_params
    params.require(:email).permit(:email, :is_primary)
  end
end
