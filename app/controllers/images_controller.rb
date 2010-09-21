class ImagesController < ApplicationController
  # GET /images
  # GET /images.xml
  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
    end
  end

  # GET /images/1
  # GET /images/1.xml
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/new
  # GET /images/new.xml
  def new
    @image = Image.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end
  
  def raw
    name = "tmp_image.png"
    data = request.raw_post
    @file_content = File.open("#{Rails.root.to_s}/tmp/#{name}", "wb") do |f| 
      f.write(data)
    end
    @image = Image.new(:attachment => File.new("#{Rails.root.to_s}/tmp/#{name}"))
    @image.save
    render :text => 'success'    
  end

  # POST /images
  # POST /images.xml
  def create
    params[:attachment].each do |upload|
      @image = Image.new(:attachment => upload)
      @image.save
    end
    
    redirect_to(images_path, :notice => "#{params[:attachment].size} images successfully uploaded")
      
    # @image = Image.new(params[:image])
    # 
    # respond_to do |format|
    #   if @image.save
    #     format.html { redirect_to(@image, :notice => 'Image was successfully created.') }
    #     format.xml  { render :xml => @image, :status => :created, :location => @image }
    #   else
    #     format.html { render :action => "new" }
    #     format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
    #   end
    # end
  end

  # PUT /images/1
  # PUT /images/1.xml
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to(@image, :notice => 'Image was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(images_url) }
      format.xml  { head :ok }
    end
  end
end
