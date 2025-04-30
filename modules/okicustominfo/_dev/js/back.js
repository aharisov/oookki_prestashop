import Sortable from 'sortablejs';

document.addEventListener("DOMContentLoaded", function () {
    const listContainer = document.getElementById("sortable-list");

    if (!listContainer) {
        console.error("Element #sortable-list not found!");
        return;
    }

    new Sortable(listContainer, {
      animation: 150,
      ghostClass: "sortable-ghost",
      onUpdate: function (evt) {
        const positions = [];
        document.querySelectorAll(".listing-row").forEach((block, index) => {
          positions.push({ id: block.getAttribute("data-id"), position: index });
        });
        let blockId = document.querySelector(".listing-row").getAttribute('data-block');

        $.ajax({
          type: "POST",
          dataType: "JSON",
          url: ajax_url,
          data: {
            ajax: true,
            action: "updateItemPositions",
            positions: JSON.stringify(positions),
            id_block: blockId
          },
          success: function (data) {
            if (data === "success") {
              console.log("Position updated successfully.");
            }
          },
          error: function (xhr, status, error) {
            console.error('ajax failed', xhr, status, error);
          },
        });
        },
    });
});


$(document).ready(function() {
  // Add new field
  $('#add-field').click(function() {
    var newField = $('#dynamic-fields-container .dynamic-field:first-child').html();

    $('<div>', { class: 'dynamic-field d-flex' })
      .append(newField)
      .appendTo('#dynamic-fields-container');
  });

  // Delete field
  $(document).on('click', '.delete-field', function() {
    $(this).closest('.dynamic-field').remove();
  });

  // Change item status Active/Inactive
  $('.toggle-status').on( "change", function() {
    let itemId = $(this).data('id');
    let blockId = $(this).data('block');
    let parent = $(this).closest('.switch-input');
    
    $.ajax({
        url: ajax_url,
        type: 'POST',
        data: {
            ajax: 1,
            action: 'toggleStatus',
            id_item: itemId,
            id_block: blockId
        },
        dataType: 'json',
        success: function (response) {
            if (response.success) {
                parent.toggleClass('checked');
            } else {
                alert('Error: ' + response.message);
            }
        },
        error: function (xhr, status, error) {
            console.error('ajax', xhr, status, error);
        }
    });
  });

  // Delete infoblock item
  $('.delete-item').click(function () {
    if (!confirm('Êtes-vous sûr de vouloir supprimer cet élément ?')) return;

    var itemId = $(this).data('id');
    let blockId = $(this).data('block');
    var $row = $(this).closest('.listing-row');

    $.ajax({
        url: ajax_url,
        type: 'POST',
        data: {
            ajax: 1,
            action: 'deleteItem',
            id_item: itemId,
            id_block: blockId
        },
        dataType: 'json',
        success: function (response) {
            if (response.success) {
                $row.fadeOut(300, function () {
                    $(this).remove();
                });
            } else {
                alert('Error: ' + response.message);
            }
        },
        error: function () {
            alert('AJAX request failed.');
        }
    });
  });

  // choose product
  $('#product-select').on('change', function () {
    const selectedId = $('#product-select option:selected').data('id');
    console.info('id', selectedId);
    $('#product-id').val(selectedId);
  });
/*
  $('#sortable-list').sortable({
    animation: 150,
    ghostClass: 'sortable-ghost',
    handle: ".drag-handle", 
    onUpdate() {
      const items = [];
      $('.listing-row').each(function () {
        items.push($(this).attr('data-id'));
      });

      $.ajax({
        type: 'POST',
        dataType: 'JSON',
        url: ajax_url, 
        data: {
          ajax: true,
          action: 'updateItemPositions',
          items,
        },
        success(response) {
          if (response.success) {
            window.showSuccessMessage("Positions updated successfully!");
          } else {
            window.showErrorMessage("Error updating positions.");
          }
        },
        error(xhr) {
          console.error("AJAX error:", xhr.responseText);
          window.showErrorMessage("An error occurred while updating positions.");
        }
      });
    },
  });*/
});
