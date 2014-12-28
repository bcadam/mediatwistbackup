class SitesController < ApplicationController
  def new  
        @site = Site.new  
  end  
    
  def create 
        require 'open-uri'
        require 'mini_magick'


        @site = Site.new()
        @site.title = params[:site][:title]
        @site.url = params[:site][:url]
        @site.body = params[:site][:body]
        @site.userid = current_user.id
        
        

        ##goes to current site and gets all of the links
        @currentimages = MetaInspector.new(@site.url)
        @site.siteassets = @currentimages.images

        @arrayofimageurls = []

        #   # @target = Target.new()
        #   # @target.siteid = @site.id
        #   # @target.url = @currentimages[$i]
        #   # @target.save

        #takes the uploaded file and places it on Parse.com

        f = params[:site][:image]

        #@site.imageinfo = f

        result = Site.upload( f.tempfile, f.original_filename)
        @site.image = {"name" => result["name"], "__type" => "File", "url" => result["url"]}

        if @site.save

          $i = 0
          count = 0
          while $i < @site.siteassets.length  do

            @basset = Basset.new()
            @basset.name = "Asset " + $i.to_s
            @basset.siteid = @site.id

            f = open(@site.siteassets[$i])

            result = Site.upload( f, @basset.name )
            @basset.image = {"name" => result["name"], "__type" => "File", "url" => result["url"]}


            image = MiniMagick::Image.open(@basset.image)

            @target = Target.new()
            @target.siteid = @site.id
            @target.height = image.height
            @target.width = image.width
            @target.url = @site.siteassets[$i]
            @target.save



            @basset.save
        
            $i +=1 

          end
          
          redirect_to "/sites", :notice => ( @site.title + " created!" )

        else  
          
          render "new"  
        
        end  

  end

  def index
        @user = current_user
        
        @sites = Site.where(:userid => @user.id)
  end

  def show
        @site = Site.find(params[:id])

        @bassets = Basset.where(:siteid => @site.id)

        @basset = Basset.new

  end

  def getpage

        require 'net/http'
        require "open-uri"

        #gather parameters from the url to indicate what the user is after
        @searchparams = params[:id]
        
        #remove the leading q= from google url
        @searchparams = @searchparams.gsub("&q=","")
        
        #take the search parameters into an array to facilitate matching
        @searchparams = @searchparams.split(' ').collect! {|n| n.to_s}

        
        
          
        

  end


end
