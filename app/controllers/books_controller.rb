class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    # @book: ←データを受け取り新規登録
    # Book.new(): ←Bookクラスの新しいインスタンスを作成するためのメソッド新しいbookのオブジェクトが作成されます。
    # (book_params)　←DBのBookテーブルに新しい行を追加する操作を行っている
    if @book.save
    #DBに保存するための実行
      flash[:notice] = "Book was successfully created."
      #【フラッシュメッセージ】データを保管する箱だけで記載しただけじゃメッセージは表示されない
      #定義をする部分なのでビューファイルに記述する必要がある。
      #新規登録した際に丈夫に一瞬だけ成功しましたと表示されるメッセージ        
      redirect_to book_path(@book.id)

      
             
      # rails routes　で調べて どこのパスに指定したいのか調べる
      # @今回はbooks/のshowに行きたいので、上記で出てきたパスの右側のbookを記入
      # 新規作成されたページに行きたいので上記で変数を作成した@bookを記入
      #@bookの後に新しく制作されたIDに飛びたいので.IDを記入
      #show画面へリダイレクトする
    else
      flash.now[:alert] = "Failed to create book."
      #定義をする部分なのでビューファイルに記述する必要がある。
      #フラッシュメッセージを作成しよう
      #新規登録に失敗したと一瞬表示されるメッセージ 
      # @books = Book.all #一覧表示をするのに必要　
      @books = Book.all
      render :index
      #新しいオブジェクトを作成するフォームを表示
    end
  end

 def index
    @book = Book.new
    @books = Book.all
  #book.all はモデルがやりとりしているDBのテーブルに保存されている、全てのレコードをまとめて取得
  end


def show
    @book = Book.find(params[:id])
end


def edit
    @book = Book.find(params[:id])
end


def update
    @book = Book.find(params[:id])
if  @book.update(book_params)
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@book.id)
else
    @books = Book.all #一覧表示をするのに必要　
    render :edit
end
end

def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
if  book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # へリダイレクト
    flash[:notice] = "Book was successfully destroyed."
end
end


 private
  def book_params
    params.require(:book).permit(:title, :body)
    #、"params"というオブジェクトから"book"というキーで指定された値だけを抽出
    #"title"と"body"のみを許可
end
end   

