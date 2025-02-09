class AddressesController < ApplicationController
  before_action :set_person
  before_action :set_address, only: [:show, :update, :destroy]

  def create
    @address = @person.addresses.build(address_params)
    if @address.save
      render json: @address, status: :created
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def show; end

  def update
    if @address.update(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy
  end

  private

  def set_person
    @person = Person.find_by(id: params[:people_id])
    render json: {error: 'Unable to find user'}, status: :unprocessable_entity if @person.nil?
  end

  def set_address
    @address = @person.addresses.find(params[:id])
    render json: {error: 'Unable to find this address'}, status: :unprocessable_entity if @address.nil?
  end

  def address_params
    params.require(:address).permit(:street, :city, :state, :country, :landmark, :postal_code, :is_primary)
  end
end
