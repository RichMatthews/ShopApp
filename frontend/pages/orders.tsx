import { gql, useQuery, ApolloClient, useApolloClient } from "@apollo/client"
import { useParams } from "next/navigation"

import { loadErrorMessages, loadDevMessages } from "@apollo/client/dev"

export default function Orders() {
  const params = useParams()

  loadDevMessages()
  loadErrorMessages()
  const GET_ORDERS = gql`
    query {
      orders(userId: 1) {
        id
        total
        insertedAt
        orderItems {
          name
          price
          quantity
          id
        }
      }
    }
  `

  const { data } = useQuery(GET_ORDERS)
  console.log(data)

  return (
    <div style={{ padding: "12px" }}>
      <h2>YOUR ORDERS</h2>
      {data?.orders.map((order) => (
        <div>
          <div>Date: {order.insertedAt}</div>
          <div>
            {order.orderItems.map((orderItem) => (
              <div>
                <span style={{ marginRight: "4px" }}>{orderItem.name}</span>
                <span style={{ marginRight: "4px" }}>
                  quantity: {orderItem.quantity}
                </span>
                <span>£{orderItem.price}</span>
              </div>
            ))}
          </div>
        </div>
      ))}
    </div>
  )
}
