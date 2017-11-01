class BoatsController < ApplicationController
	before_action :set_boat, only: [:edit,:profile,:handle_update,:handle_delete]
	# Boats profile page
	def profile
		@boat = Boat.find_by(params[:id])
		@origin_jobs = Job.where(origin: @boat.jobs.first.origin)
	end

	# New boat page
	def new
		@boat = Boat.new
	end

	# Edit boat page
	def edit
	end

	# Create boat
	def handle_create
	    @boat = Boat.new(boat_params)
	    @boat.user_id = current_user.id
	    respond_to do |format|
	      if @boat.save
	        format.html { redirect_to boat_path, notice: 'Boat was successfully created.' }
	      else
	        format.html { render :new }
	      end
	    end
	end

	# Update boat
	def handle_update
	    respond_to do |format|
	      if @boat.update(boat_params)
	        format.html { redirect_to boat_path, notice: 'Boat was successfully updated.' }
	      else
	        format.html { render :edit }
	      end
	    end
	end

	# Delete boat
	def handle_delete
	    @boat.destroy
	    respond_to do |format|
	      format.html { redirect_back fallback_location: :root, notice: 'Boat was successfully destroyed.' }
	    end
	end

	# Add job
	  def add_job
	    @assignment = Assignment.new(assignment_params)
	    respond_to do |format|
	      if @assignment.save
	      format.html { redirect_to boat_path, notice: 'Job was successfully added.' }
	      else
	        format.html { render boat_path }
	      end
	    end
	  end

	private

	def set_boat
		@boat = Boat.find_by(id: params[:id])
	end

	def boat_params
		params.require(:boat).permit(:name, :storage, :location)
	end
    def assignment_params
      params.permit(:job_id, :boat_id)
    end
end
