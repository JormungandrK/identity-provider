### Multi-stage build
FROM jormungandrk/goa-build as build

COPY . /go/src/github.com/Microkubes/identity-provider
RUN go install github.com/Microkubes/identity-provider


### Main
FROM alpine:3.7

COPY --from=build /go/bin/identity-provider /usr/local/bin/identity-provider
COPY public /public
EXPOSE 8080

ENV API_GATEWAY_URL="http://localhost:8001"

CMD ["/usr/local/bin/identity-provider"]
