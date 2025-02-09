class PeoplesController < ApplicationController
  before_action :set_person, only: [:show, :update, :destroy, :restore]

  def index
    render json: Person.includes(:addresses, :phone_numbers, :emails).with_deleted.all, include: [:addresses, :phone_numbers, :emails], status: 200
  end

  def show
    render json: @person, include: [:addresses, :phone_numbers, :emails], status: 200
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      render json: @person, status: :created
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  def update
    if @person.update(person_params)
      render json: @person
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @person.destroy
      render json: { message: 'Person was successfully deleted' }, status: :ok
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  def restore
    if @person.restore
      render json: { message: 'Person was successfully restored' }, status: :ok
    else
      render json: { error: 'Unable to restore person' }, status: :unprocessable_entity
    end
  end

  def destroy_multiple
    @people = Person.where(id: params[:ids])
    if @people.destroy_all
      render json: { message: 'Users deleted successfully' }, status: :ok
    else
      render json: { error: 'Failed to delete users' }, status: :unprocessable_entity
    end
  end

  private

  def set_person
    @person = Person.with_deleted.find_by(id: params[:id])
    render json: {error: 'Unable to find user'}, status: :unprocessable_entity if @person.nil?
  end

  def person_params
    params.require(:people).permit(
      :first_name, :last_name, :date_of_birth, addresses_attributes: [:id, :person_id, :street, :landmark, :city, :state, :country, :postal_code, :is_primary, :_destroy], phone_numbers_attributes: [:id, :person_id, :mobile_number, :is_primary, :_destroy], emails_attributes: [:id, :person_id, :email, :is_primary, :_destroy]
    )
  end
end
