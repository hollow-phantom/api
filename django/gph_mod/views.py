from django.shortcuts import render
from rest_framework import generics
from rest_framework.views import APIView
from django.db import connection
from django.db import connections
from rest_framework.response import Response
from rest_framework import status


# Create your views here.
class ProcListView(APIView):
    ### GET時の処理
    def get(self, request):
        # 引数取得
        gph_no = request.GET.get("gph_no")

        ### SQL実行
        with connections["ZaikoDB"].cursor() as cursor:
            ### SQL文定義
            cursor.execute(
                """
            SELECT
                *
            FROM
                dbo.PSK_データ_現品票_工程詳細
            WHERE
                [現品票NO] = %s
            """,
                [
                    gph_no,
                ],
            )
            columns = [col[0] for col in cursor.description]
            rows = cursor.fetchall()

        ### 結果をdictへ格納し、JSON形式でResponse
        results = [dict(zip(columns, row)) for row in rows]
        return Response(results, status=status.HTTP_200_OK)
