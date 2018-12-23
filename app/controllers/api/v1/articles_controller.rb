# frozen_string_literal: true

module Api
  module V1
    # ArticlesController
    class ArticlesController < ApplicationController
      before_action :set_article, only: %i[show update destroy]

      # GET /articles
      def index
        !Article.count.positive? && set_articles
        articles = Article.order('created_at DESC')
        render json: {
          code: '0',
          data: articles
        }, status: :ok
      end

      # GET /articles/1
      def show
        render json: @article
      end

      # POST /articles
      def create
        @article = Article.new(article_params)

        if @article.save
          render json: @article, status: :created, location: @article
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /articles/1
      def update
        if @article.update(article_params)
          render json: @article
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      # DELETE /articles/1
      def destroy
        @article.destroy
      end

      private

      # Set default data if database is empty
      def set_articles
        12.times do
          Article.create(
            title: Faker::Book.title,
            body: Faker::Lorem.sentence * 500,
            type: Faker::WorldOfWarcraft.hero,
            stars: Faker::Number.between(1, 100),
            created_by: Faker::SwordArtOnline.game_name
          )
        end
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_article
        @article = Article.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def article_params
        params.require(:article).permit(
          :title, :content, :type, :tags, :stars, :created_by
        )
      end
    end
  end
end
