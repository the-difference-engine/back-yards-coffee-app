class EditablesController < ApplicationController

  def edit
    @editable = Editable.find(params[:id])
  end

  def update
    respond_to do |format|
      @editable = Editable.find(params[:id])
      if @editable.update(editable_params)
        format.html { redirect_to '/about', notice: 'Editable was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def editable_params
      params.permit(:about_me_sec_1, :about_me_pic_1, :about_me_sec_2, :about_me_pic_2, :about_me_sec_3,:about_me_pic_3)
    end
end
