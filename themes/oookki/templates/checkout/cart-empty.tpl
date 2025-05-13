{extends file=$layout}

{block name="content"}
  <div class="cont">
    <div class="cart-empty">
      <div class="empty-icon">
        <i class="fa-solid fa-cart-shopping"></i>
        <h2>Votre panier est vide.</h2>
      </div>

      <div class="content flex">
        <div class="content-item">
          <h3>Besoin d'un forfait ?</h3>
          <a href="/3-abonnements" class="btn btn-black__empty">Choisir</a>
        </div>
        <div class="content-item">
          <h3>Besoin d'un téléphone ?</h3>
          <a href="/5-mobiles" class="btn btn-black__empty">Choisir</a>
        </div>
        <div class="content-item">
          <h3>Besoin d'autre chose ?</h3>
          <a href="/" class="btn btn-black__empty">Choisir</a>
        </div>
      </div>
    </div>
  </div>
{/block}