# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_10_123345) do
  create_table "formulario_respondidos", force: :cascade do |t|
    t.integer "usuario_id", null: false
    t.integer "formulario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["formulario_id"], name: "index_formulario_respondidos_on_formulario_id"
    t.index ["usuario_id"], name: "index_formulario_respondidos_on_usuario_id"
  end

  create_table "formularios", force: :cascade do |t|
    t.integer "usuario_publicador_id", null: false
    t.integer "template_id", null: false
    t.date "data_abertura"
    t.date "data_fechamento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_formularios_on_template_id"
    t.index ["usuario_publicador_id"], name: "index_formularios_on_usuario_publicador_id"
  end

  create_table "materia", force: :cascade do |t|
    t.string "nome"
    t.string "codigo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opcaos", force: :cascade do |t|
    t.integer "pergunta_id", null: false
    t.string "descricao"
    t.integer "ordem"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pergunta_id"], name: "index_opcaos_on_pergunta_id"
  end

  create_table "pergunta", force: :cascade do |t|
    t.integer "template_id", null: false
    t.string "titulo"
    t.text "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_pergunta_on_template_id"
  end

  create_table "resposta", force: :cascade do |t|
    t.integer "pergunta_id", null: false
    t.integer "opcao_id", null: false
    t.text "justificativa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["opcao_id"], name: "index_resposta_on_opcao_id"
    t.index ["pergunta_id"], name: "index_resposta_on_pergunta_id"
  end

  create_table "templates", force: :cascade do |t|
    t.integer "usuario_criador_id", null: false
    t.string "titulo"
    t.text "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_criador_id"], name: "index_templates_on_usuario_criador_id"
  end

  create_table "turma_alunos", force: :cascade do |t|
    t.integer "aluno_id", null: false
    t.integer "turma_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aluno_id"], name: "index_turma_alunos_on_aluno_id"
    t.index ["turma_id"], name: "index_turma_alunos_on_turma_id"
  end

  create_table "turma_formularios", force: :cascade do |t|
    t.integer "turma_id", null: false
    t.integer "formulario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["formulario_id"], name: "index_turma_formularios_on_formulario_id"
    t.index ["turma_id"], name: "index_turma_formularios_on_turma_id"
  end

  create_table "turma_professors", force: :cascade do |t|
    t.integer "professor_id", null: false
    t.integer "turma_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["professor_id"], name: "index_turma_professors_on_professor_id"
    t.index ["turma_id"], name: "index_turma_professors_on_turma_id"
  end

  create_table "turmas", force: :cascade do |t|
    t.integer "materia_id", null: false
    t.integer "numero"
    t.string "semestre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["materia_id"], name: "index_turmas_on_materia_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nome"
    t.string "matricula"
    t.string "email"
    t.string "cargo"
    t.string "senha_hash"
    t.string "senha_salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "formulario_respondidos", "formularios"
  add_foreign_key "formulario_respondidos", "usuarios"
  add_foreign_key "formularios", "templates"
  add_foreign_key "formularios", "usuarios", column: "usuario_publicador_id"
  add_foreign_key "opcaos", "pergunta", column: "pergunta_id"
  add_foreign_key "pergunta", "templates"
  add_foreign_key "resposta", "opcaos"
  add_foreign_key "resposta", "pergunta", column: "pergunta_id"
  add_foreign_key "templates", "usuarios", column: "usuario_criador_id"
  add_foreign_key "turma_alunos", "turmas"
  add_foreign_key "turma_alunos", "usuarios", column: "aluno_id"
  add_foreign_key "turma_formularios", "formularios"
  add_foreign_key "turma_formularios", "turmas"
  add_foreign_key "turma_professors", "turmas"
  add_foreign_key "turma_professors", "usuarios", column: "professor_id"
  add_foreign_key "turmas", "materia", column: "materia_id"
end
