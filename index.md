---
hero: true
---

<section class="section news">
  <div class="section-inner">
    <h2>Latest News</h2>

    <div class="columns-3">
      {% for post in site.posts limit:3 %}
      {% include news-item.html %}
      {% endfor %}
    </div>

    <div class="buttons">
      <a href="{{ '/news' | relative_url }}" class="button-primary">News archive</a>
    </div>
  </div>
</section>

---

<section class="section section--alt section--side-image-left about">
  <div class="side-image" style="background-image: url('{{ '/assets/img/screenshot-1.jpeg' | relative_url }}'); background-position: 0 0"></div>
  <div class="right-from-side-image">
    <div class="section-inner">
      <h2>What is Healthy?</h2>
      <p>More information soon.</p>
      <div class="buttons">
        <a href="{{ '/features' | relative_url }}" class="button-primary">All features</a>
        <a href="{{ '/docs' | relative_url }}" class="button-primary">Documentation</a>
      </div>
    </div>
  </div>
</section>

---

<section id="get" class="section get-healthy">
  <div class="section-inner">
    <h2>Get Healthy</h2>

    <p>Download Healthy and keep your WordPress site in perfect shape.</p>

    <ol>
      <li>Download the plugin</li>
      <li>Extract and upload it to `/wp-content/plugins/`</li>
      <li>Activate it in the WordPress admin</li>
      <li>Find `Healthy` in the `Settings` menu and get the monitoring endpoint</li>
    </ol>

    <div class="buttons">
      <a href="https://github.com/vincentbitter/healthy/releases" class="button-primary">Download Healthy</a>
    </div>
  </div>
</section>