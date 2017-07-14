defmodule Chronos.PhotoController do
  use Chronos.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: Chronos.AuthHandler

  alias Chronos.Photo

  def new(conn, _params) do
    changeset = Photo.changeset(%Photo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"photo" => photo_params}) do
    upload = photo_params["upload"]
    case File.read(upload.path) do
      {:ok, bin} ->
        path = "photos/#{UUID.uuid4(:hex)}#{Path.extname(upload.filename)}"
        case ExAws.S3.put_object("chronos-timeline", path, bin, acl: :public_read) |> ExAws.request() do
          {:ok, _} ->
            photo = %Photo{uploader: Guardian.Plug.current_resource(conn).email, s3_path: path}
            changeset = Photo.changeset(photo, photo_params)
            case Repo.insert(changeset) do
              {:ok, _photo} ->
                conn
                |> put_flash(:info, "Photo created successfully.")
                |> redirect(to: event_path(conn, :index))
              {:error, changeset} ->
                render(conn, "new.html", changeset: changeset)
            end
          _ ->
            conn
            |> put_flash(:error, "Unable to put object to S3")
            |> render("new.html", changeset: Photo.changeset(%Photo{}))
        end
      _ ->
        conn
        |> put_flash(:error, "Unable to read file")
        |> render("new.html", changeset: Photo.changeset(%Photo{}))
    end
  end

  def show(conn, %{"id" => id}) do
    photo = Repo.get!(Photo, id)
    render(conn, "show.html", photo: photo)
  end

  def delete(conn, %{"id" => id}) do
    photo = Repo.get!(Photo, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(photo)

    conn
    |> put_flash(:info, "Photo deleted successfully.")
    |> redirect(to: event_path(conn, :index))
  end
end
