import { ApolloProvider, gql, useQuery } from "@apollo/client"

import { client } from "../client"
import "./app.css"
import Link from "next/link"

export default function MyApp({ Component, pageProps }) {
  return (
    <ApolloProvider client={client}>
      <Navigation />
      <Cart />
      <Component {...pageProps} />
    </ApolloProvider>
  )
}

const Cart = () => {
  if (typeof window == "undefined") {
    return <div />
  }

  const products = JSON.parse(window.localStorage.getItem("shopApp::cartData"))

  console.log(products)
  const empty = products.length === 0

  return (
    <div
      style={{
        position: "absolute",
        right: 0,
        margin: "20px",
        border: "1px solid #ccc",
        padding: "20px",
        width: "200px",
      }}
    >
      <h4>Cart</h4>
      <div style={{ paddingBottom: "12px" }}>
        {empty ? "No items in cart" : "Items"}
      </div>
      <div>
        {products.map((product) => (
          <div style={{ display: "flex", justifyContent: "space-between" }}>
            <div>
              <span>{product.name}</span>
            </div>
            <div>
              <span>{product.quantity}</span>
              <span style={{ cursor: "pointer", padding: "0 4px" }}>+</span>
              <span style={{ cursor: "pointer", padding: "0 4px" }}>-</span>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
const Navigation = () => {
  const { data } = useQuery(GET_USER, {
    variables: { id: "01909707-286b-7111-922d-94d8db837d4a" },
  })

  return (
    <div
      style={{
        background: "black",
        color: "#fff",
        margin: 0,
        padding: "12px",
      }}
    >
      <Link
        href="/"
        style={{ color: "#fff", textDecoration: "none", marginRight: "20px" }}
      >
        Home
      </Link>
      <Link
        href="/orders"
        style={{ color: "#fff", marginRight: "20px", textDecoration: "none" }}
      >
        Orders
      </Link>
      <Link
        href="/admin"
        style={{ color: "#fff", marginRight: "20px", textDecoration: "none" }}
      >
        Admin
      </Link>
      <Link href="/" style={{ color: "#fff", textDecoration: "none" }}>
        {data?.user.username}
      </Link>
    </div>
  )
}

const GET_USER = gql`
  query getUser($id: UUID!) {
    user(id: $id) {
      username
      id
      name
    }
  }
`
