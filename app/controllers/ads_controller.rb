class AdsController < ApplicationController
  before_action :authorize_request
  
  def index 
  #  @ads = Ad.all
   @ads = Ad.where(nil) 
   @ads = @ads.filter_by_title(params[:title]) if params[:title].present?
   @ads = @ads.filter_by_location(params[:location]) if params[:location].present?
   @ads = @ads.filter_by_featured(params[:featured]) if params[:featured].present?
   @ads = @ads.filter_by_price(params[:min],params[:max]) if params[:min].present?
  #  @ads = @ads.filter_by_price(params[:price]) if params[:price].present?
   @ads = @ads.filter_by_brand_name(params[:brand_name]) if params[:brand_name].present?
   @ads = @ads.filter_by_transmission_type(params[:transmission_type]) if params[:transmission_type].present?

   if @ads.present?
     render json:@ads
   else
     render json:"No Ads ! Please Create Ad"
   end
 end

 def create   
   @ad = Ad.create(ad_params)
   @ad.save!
   if @ad.present? 
     render json:@ad
   else
     render json:"Error Occured"
   end
 end

 def show 
   @ad = Ad.find_by(id: params[:id])
   if @ad.present? && @ad.user_id == @current_user.id
    @view = View.find_or_create_by(view_params)
    @view&.total_views = @view&.total_views.next
    @view.save!
    render json: @ad.to_json(include: [:views])
   else 
     render json:"Ad Not Found"
   end
 end
 
 def update
   @ad = Ad.find_by(id: params[:id])
   if @ad.present? && @ad.user_id == @current_user.id
     @ad.update(ad_params)
     render json: @ad
   else
     render json:"Ad not found"
   end
   
 end
 
 def destroy
   @ad = Ad.find_by(id:params[:id])
   if @ad.present? && @ad.user_id==@current_user.id
     @ad.destroy
     render json:"#{@ad.title} Sucessfully deleted"
   else
     render json:"Ad not found"
   end
 end
 
 def ad_params
   params.permit(
     :title, :featured, :brand_name, :location, :transmission_type,:price,:leased, :images).merge(user_id: @current_user.id)
 end
 
 def view_params
  params.permit(:plateforms, :useragents).merge(ad_id: @ad.id)
end

end
