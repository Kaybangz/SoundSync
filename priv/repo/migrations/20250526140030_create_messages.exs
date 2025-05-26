defmodule SoundSync.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :space_id, references(:spaces, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :content, :text, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:messages, [:space_id])
    create index(:messages, [:user_id])

    create index(:messages, [:space_id, :inserted_at])

    create constraint(:messages, :content_length,
             check: "char_length(content) >= 1 AND char_length(content) <= 1000"
           )
  end
end
