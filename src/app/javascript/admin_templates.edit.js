function deleteQuestion(btn) {
    const field = btn.closest('.question-fields');
    const destroy = field.querySelector('.destroy-question-field');
    destroy.value = '1';
    field.classList.add('deleted-question-field');
}
function deleteOption(btn) {
    const field = btn.closest('.option-field');
    const destroy = field.querySelector('.destroy-option-field');
    destroy.value = '1';
    field.classList.add('deleted-option-field');
}

function addListeners() {
    const addBtn = document.getElementById("add-question-btn");
    const questionsList = document.getElementById("questions-list");

    function buildOptionField(qIndex, oIndex) {
        return `
        <div class="option-field" data-option-index="${oIndex}">
            <input class="form-control" type="text" name="template[questions_attributes][${qIndex}][options_attributes][${oIndex}][description]" placeholder="Option name" />
            <button type="button" class="delete-option-btn-x" title="Delete option">&times;</button>
        </div>
        `;
    }

    function buildOptionsArea(qIndex) {
        return `
        <div class="options-area">
            <label>Options</label>
            <div class="options-list">
                ${buildOptionField(qIndex, 0)}
            </div>
            <button type="button" class="add-option-btn" data-question-index="${qIndex}" style="margin-top:8px;">Add Option</button>
        </div>
        `;
    }

    function buildQuestionFields(index) {
        return `
        <div class="question-fields" data-question-index="${index}">
            <button type="button" class="delete-question-btn-x" title="Delete question">&times;</button>
            <div class="form-group">
                <label for="template_questions_attributes_${index}_title">Question Name</label>
                <input class="form-control" type="text" name="template[questions_attributes][${index}][title]" id="template_questions_attributes_${index}_title" />
            </div>
            <div class="form-group">
                <label for="template_questions_attributes_${index}_answer_type">Answer Type</label>
                <select class="form-control answer-type-select" name="template[questions_attributes][${index}][answer_type]" id="template_questions_attributes_${index}_answer_type">
                    <option value="text" selected>Text</option>
                    <option value="radio">Radio</option>
                </select>
            </div>
        </div>
        `;
    }

    if(addBtn) {
        let questionIndex = questionsList.children.length;
        addBtn.addEventListener("click", function(e) {
            e.preventDefault();
            questionsList.insertAdjacentHTML("beforeend", buildQuestionFields(questionIndex));
            questionIndex++;
        });
    }

    if(questionsList) {
        questionsList.addEventListener("change", function(e) {
            if (e.target.classList.contains("answer-type-select")) {
                const questionFields = e.target.closest(".question-fields");
                const qIndex = questionFields.dataset.questionIndex;
                let optionsArea = questionFields.querySelector(".options-area");
                if (e.target.value === "radio") {
                    if (!optionsArea) {
                        questionFields.insertAdjacentHTML("beforeend", buildOptionsArea(qIndex));
                    }
                } else {
                    if (optionsArea) optionsArea.remove();
                }
            }
        });

        questionsList.addEventListener("click", function(e) {

            if (e.target.classList.contains("delete-question-btn-x")) {
                e.target.closest(".question-fields").remove().classList.add('display-none');
            }

            if (e.target.classList.contains("add-option-btn")) {
                const questionFields = e.target.closest(".question-fields");
                const qIndex = questionFields.dataset.questionIndex;
                const optionsList = questionFields.querySelector(".options-list");
                const optionFields = optionsList.querySelectorAll(".option-field");
                const oIndex = optionFields.length;
                optionsList.insertAdjacentHTML("beforeend", buildOptionField(qIndex, oIndex));
            }

            if (e.target.classList.contains("delete-option-btn-x")) {
                e.target.closest(".option-field").classList.add('display-none');
            }
        });

    }

    document.querySelectorAll(".answer-type-select").forEach(function(select) {
        select.dispatchEvent(new Event("change"));
    });
}

// document.addEventListener("turbo:load", addListeners);
// document.addEventListener("DOMContentLoaded", addListeners);
addListeners();