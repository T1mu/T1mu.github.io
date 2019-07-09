<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.authoricon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
</div>

{% if theme.copyright %}
<div class="powered-by">
  {{ __('footer.powered', '') }}
</div>

<div class="theme-info">
  {{ __('footer.theme') }} 
</div>
{% endif %}

<!--添加网站的运行时间-->
<span id="sitetime"> <br></span>
<script language="javascript">
  function siteTime(){
    window.setTimeout("siteTime()", 1000);
    var seconds = 1000
    var minutes = seconds * 60
    var hours = minutes * 60
    var days = hours * 24
    var years = days * 365

    var today = new Date()
    var todayYear = today.getFullYear()
    var todayMonth = today.getMonth()
    var todayDate = today.getDate()
    var todayHour = today.getHours()
    var todayMinute = today.getMinutes()
    var todaySecond = today.getSeconds()
    var t1 = Date.UTC(2017,4,18,11,00,00)
    var t2 = Date.UTC(todayYear,todayMonth,todayDate,todayHour,todayMinute,todaySecond)
    var diff = t2-t1

    var diffYears = Math.floor(diff/years)
    var diffDays = Math.floor((diff/days)-diffYears*365)
    var diffHours = Math.floor((diff-(diffYears*365+diffDays)*days)/hours)
    var diffMinutes = Math.floor((diff-(diffYears*365+diffDays)*days-diffHours*hours)/minutes)
    var diffSeconds = Math.floor((diff-(diffYears*365+diffDays)*days-diffHours*hours-diffMinutes*minutes)/seconds)
    document.getElementById("sitetime").innerHTML=" \r 本站已运行"+diffYears+" 年 "+diffDays+" 天 "+diffHours+" 小时 "+diffMinutes+" 分钟 "+diffSeconds+" 秒<br>"
  }
  siteTime()
</script>
