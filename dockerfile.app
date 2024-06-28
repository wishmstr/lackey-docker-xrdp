FROM lackey-base

WORKDIR /app

COPY src /app

COPY entrypoint.sh /app/entrypoint.sh

RUN addgroup --system app
RUN adduser --home /app --ingroup app app
RUN chown -R app:app /app

USER app

RUN curl -LO https://lackeyccg.com/LackeyCCGWin.zip
RUN unzip LackeyCCGWin.zip -d .
RUN chmod -R 755 LackeyCCG

ENV USER=root
ENV DISPLAY=:0

ENTRYPOINT [ "/app/entrypoint.sh" ]
