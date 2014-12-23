class SitesController < ApplicationController
  def new  
        @site = Site.new  
  end  
    
  def create  

        @site = Site.new()
        @site.title = params[:site][:title]
        @site.url = params[:site][:url]
        @site.body = params[:site][:body]
        @site.userid = current_user.id
        
        f = params[:site][:image]

        ##goes to current site and gets all of the links
        @currentimages = MetaInspector.new(@site.url)
        @currentimages = @currentimages.images

        @arrayofimageurls = []
        
        $i = 0
        count = 0
        while $i < @currentimages.length  do
          @arrayofimageurls.push(@currentimages[$i])
          $i +=1 
        end



        @site.siteassets = @arrayofimageurls
        ##end of fetching site assets


        #takes the uploaded file and places it on Parse.com
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

            result = Site.upload( f, @basset.name)
            @basset.image = {"name" => result["name"], "__type" => "File", "url" => result["url"]}

            @basset.save
        
            $i +=1 

          end
          
          redirect_to "/sites", :notice => ( @site.title + " created!" )
          #redirect_to "/sites", :notice => imageArray

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
        #@searchparams = params[:id]
        
        #remove the leading q= from google url
        #@searchparams = @searchparams.gsub("&q=","")
        
        #take the search parameters into an array to facilitate matching
        #@searchparams = @searchparams.split(' ').collect! {|n| n.to_s}

        
        # @basset = Basset.new()
        # @basset.name = "name"
        # @basset.siteid = "asdfasdf"

    
        # f = open("http://startbootstrap.com/assets/img/templates/agency.jpg")

        # #@site.imageinfo = f

        # result = Site.upload( f, "name")
        # @basset.image = {"name" => result["name"], "__type" => "File", "url" => result["url"]}

        # @basset.save
          
        

  end


end
