class FormController < ApplicationController

  def getUserForms
    usuario_id = session[:usuario_id]
    return head :unauthorized unless usuario_id

    usuario = Usuario.find(usuario_id)

    turma_ids = []
    turma_ids += usuario.turma_alunos.pluck(:turma_id) if usuario.respond_to?(:turma_alunos)
    turma_ids += usuario.turma_professors.pluck(:turma_id) if usuario.respond_to?(:turma_professors)
    turma_ids.uniq!

    formularios = Formulario.joins(:turma_formularios)
                            .where(turma_formularios: {turma_id: turma_ids})
                            .distinct
    result = formularios.map do |formulario|
      turma = formulario.turma_formularios.first&.turma
      next unless turma
      professor = turma.turma_professors.first&.professor
      {
        id: turma.id,
        materia: turma.materia&.nome,
        semestre: turma.semestre,
        professor: professor&.nome,
        respondido: FormularioRespondido.exists?(usuario_id: usuario.id, formulario_id: formulario.id)
      }
    end.compact

    render json: result
  end

end
