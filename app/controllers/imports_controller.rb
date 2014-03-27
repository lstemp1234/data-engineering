class ImportsController < ApplicationController
  require 'csv'

  def index
  end

  def show
  end

  def create
    respond_to do |format|
      if import_csv
        format.html {
          flash[:notice] = 'Data was successfully imported.'
          render action: 'show'
        }
      else
        format.html {
          flash[:alert] = 'Import failed.'
          redirect_to action: 'index'
        }
      end
    end
  end

  private
    def import_csv
      begin
        data = CSV.parse(params[:data].read, { headers: true, col_sep: "\t" })
        @gross_revenue = Import.import_data(data)
      rescue Exception => e
        return false
      end

      return true
    end
end
