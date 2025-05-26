defmodule SoundSync.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :phone_number, :string, null: false
      add :username, :string, null: false
      add :profile_picture_url, :string, null: true
      add :password_hash, :string, null: false
      add :session_expires_at, :naive_datetime, null: true

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:phone_number])
    create unique_index(:users, [:username])

    create index(:users, [:session_expires_at])

    create constraint(:users, :phone_number_format,
             check: "phone_number ~ '^\\+?[1-9]\\d{1,14}$'"
           )

    create constraint(:users, :username_length,
             check: "char_length(username) >= 3 AND char_length(username) <= 20"
           )
  end
end
