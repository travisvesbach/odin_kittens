class KittensController < ApplicationController

	def index
		@kittens = Kitten.all
		respond_to do |format|
			format.html
			format.xml { render :xml => @kittens }
			format.json { render :json => @kittens }
		end
	end

	def show
		@kitten = Kitten.find_by(id: params[:id])
		respond_to do |format|
			format.html
			format.xml { render :xml => @kitten }
			format.json { render :json => @kitten }
		end
	end

	def new
		@kitten = Kitten.new
		@age = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
		@cuteness = [1,2,3,4,5,6,7,8,9,10]
		@softness = [1,2,3,4,5,6,7,8,9,10]
	end

	def create
		@kitten = Kitten.new(get_params)
		if @kitten.save
			flash[:success] = "#{@kitten.name} saved!"
			redirect_to @kitten
		else
			flash.now[:danger] = 'Something went wrong! Kitten was not saved!'
			render :new
		end
	end

	def edit
		@kitten = Kitten.find_by(id: params[:id])
		@age = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
		@cuteness = [1,2,3,4,5,6,7,8,9,10]
		@softness = [1,2,3,4,5,6,7,8,9,10]
	end

	def update
		@kitten = Kitten.find_by(id: params[:id])
		if @kitten.update(get_params)
			flash[:success] = "Success! #{@kitten.name} was updated!"
			redirect_to @kitten
		else
			flash.now[:danger] = "Something went wrong! #{@kitten.name} was not updated!"
			render 'edit'
		end
	end

	def destroy
		Kitten.destroy(params[:id])
		flash[:success] = 'A kitten was destroyed!'
		redirect_to root_url
	end

	private

		def get_params
			params.require(:kitten).permit(:name, :age, :cuteness, :softness)
		end

end
