class DnsController < ApplicationController
  before_action :set_dns, only: [:show, :update, :destroy]

  def index
    render json: Dns.all
  end

  def show
    render json: @dns
  end

  def create
    @dns = Dns.new(dn_params)

    if @dns.save
      render json: @dns, status: :created, location: @dns
    else
      render json: @dns.errors, status: :unprocessable_entity
    end
  end

  def update
    if @dns.update(dn_params)
      render json: @dns
    else
      render json: @dns.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @dns.destroy
  end

  private
    def set_dns
      @dns = Dns.find(params[:id])
    end

    def dn_params
      params.require(:dns).permit(:ip, domains: [])
    end
end
