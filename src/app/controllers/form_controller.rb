class FormController < ApplicationController

  def index
    usuario_id = session[:usuario_id]
    return head :unauthorized unless usuario_id

    usuario = Usuario.find(usuario_id)

    turma_ids = []
    turma_ids += usuario.turma_alunos.pluck(:turma_id) if usuario.respond_to?(:turma_alunos)
    turma_ids += usuario.turma_professors.pluck(:turma_id) if usuario.respond_to?(:turma_professors)
    turma_ids.uniq!

    turmas = Turma.includes(:materia, :professors)
                  .where(id: turma_ids)

    result = turmas.map do |turma|
      professor = turma.turma_professors.first&.professor
      {
        id: turma.id,
        materia: turma.materia&.nome,
        semestre: turma.semestre,
        professor: professor&.nome
      }
    end

    render json: result
  end

end
