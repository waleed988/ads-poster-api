class ViewsController < ApplicationController
  def create
    @view = View.create(view_params)
    @view.save!
    if @view.present? 
      render json:@ad
    else
      render json:"Error Occured"
    end
  end
end
